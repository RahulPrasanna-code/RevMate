import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../providers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final notificationServiceProvider = Provider((ref) {
  return NotificationService(ref);
});

class NotificationService {
  final Ref _ref;
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final _storage = const FlutterSecureStorage();

  NotificationService(this._ref);

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notifications.initialize(initSettings);
  }

  Future<void> checkAndNotify() async {
    final db = _ref.read(dbProvider);
    final bikes = await db.watchAllBikes().first;
    if (bikes.isEmpty) return;

    final bike = bikes.first;
    final now = DateTime.now();

    // 1. Insurance Expiry (within 30 days)
    if (bike.insuranceExpiry.difference(now).inDays <= 30) {
      await _showNotification(
        1,
        'Insurance Expiry',
        'Your insurance for ${bike.name} expires on ${bike.insuranceExpiry.toString().split(' ').first}.',
      );
    }

    // 2. PUC Expiry (within 30 days)
    if (bike.pucExpiry.difference(now).inDays <= 30) {
      await _showNotification(
        2,
        'PUC Expiry',
        'Your PUC for ${bike.name} expires on ${bike.pucExpiry.toString().split(' ').first}.',
      );
    }

    // 3. Service Due (within 500km or 7 days)
    final latestService = await db.getLatestServiceLog(bike.id);
    if (latestService != null) {
      bool notifyService = false;
      if (latestService.nextDueDate != null &&
          latestService.nextDueDate!.difference(now).inDays <= 7) {
        notifyService = true;
      }
      if (latestService.nextDueOdometer != null &&
          (latestService.nextDueOdometer! - bike.currentOdometer) <= 500) {
        notifyService = true;
      }

      if (notifyService) {
        await _showNotification(
          3,
          'Service Due',
          'Service for ${bike.name} is due soon.',
        );
      }
    }

    // 4. Tyre Pressure Reminder (every 15 days)
    final lastTyreCheckStr = await _storage.read(key: 'last_tyre_check');
    DateTime? lastTyreCheck = lastTyreCheckStr != null ? DateTime.tryParse(lastTyreCheckStr) : null;
    
    if (lastTyreCheck == null || now.difference(lastTyreCheck).inDays >= 15) {
      await _showNotification(
        4,
        'Tyre Pressure Check',
        'It\'s been 15 days since your last tyre pressure check for ${bike.name}.',
      );
      // We don't auto-update the date here, the user should ideally confirm they checked it.
      // But for the sake of the reminder working on next launch if they ignore it, we keep it as is.
    }
  }

  Future<void> _showNotification(int id, String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'revmate_alerts',
      'RevMate Alerts',
      channelDescription: 'Notifications for bike maintenance and expiries',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(id, title, body, notificationDetails);
  }

  Future<void> markTyreChecked() async {
    await _storage.write(key: 'last_tyre_check', value: DateTime.now().toIso8601String());
  }
}
