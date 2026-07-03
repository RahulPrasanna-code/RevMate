import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final himalayanDashProvider = Provider((ref) => HimalayanDashService());

class HimalayanDashService {
  static const _methodChannel = MethodChannel('com.revmate/himalayan_dash');
  static const _eventChannel = EventChannel('com.revmate/himalayan_events');

  final _statusController = StreamController<String>.broadcast();
  final _telemetryController = StreamController<List<int>>.broadcast();
  final _buttonController = StreamController<int>.broadcast();

  Stream<String> get statusStream => _statusController.stream;
  Stream<List<int>> get telemetryStream => _telemetryController.stream;
  Stream<int> get buttonStream => _buttonController.stream;

  HimalayanDashService() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final map = event as Map;
      final type = map['type'] as String;
      final data = map['data'];

      switch (type) {
        case 'status':
          _statusController.add(data as String);
          break;
        case 'telemetry':
          final raw = data as String;
          final bytes = raw.split(',').map((e) => int.parse(e)).toList();
          _telemetryController.add(bytes);
          break;
        case 'button':
          _buttonController.add(data as int);
          break;
      }
    });
  }

  Future<void> connect(String ssid) async {
    await _methodChannel.invokeMethod('connect', {'ssid': ssid});
  }

  Future<void> disconnect() async {
    await _methodChannel.invokeMethod('disconnect');
  }
}
