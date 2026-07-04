import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/services/himalayan_dash_service.dart';

class HimalayanDashScreen extends ConsumerStatefulWidget {
  const HimalayanDashScreen({super.key});

  @override
  ConsumerState<HimalayanDashScreen> createState() => _HimalayanDashScreenState();
}

class _HimalayanDashScreenState extends ConsumerState<HimalayanDashScreen> {
  String _status = 'Disconnected';
  List<int> _telemetry = [];
  int? _lastButton;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    final service = ref.read(himalayanDashProvider);
    service.statusStream.listen((s) {
      if (mounted) {
        setState(() {
          _status = s;
          if (s == 'connected' || s == 'disconnected') {
            _isConnecting = false;
          }
        });
      }
    });
    service.telemetryStream.listen((t) {
      if (mounted) setState(() => _telemetry = t);
    });
    service.buttonStream.listen((b) {
      if (mounted) setState(() => _lastButton = b);
    });
  }

  Future<void> _handleConnect() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      setState(() => _isConnecting = true);
      await ref.read(himalayanDashProvider).connect('RE_Himalayan');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is required for Wi-Fi connection')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isConnected = _status == 'connected';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Himalayan 450 Dash'),
        actions: [
          if (isConnected)
            IconButton(
              icon: const Icon(Icons.link_off),
              onPressed: () => ref.read(himalayanDashProvider).disconnect(),
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceVariant.withOpacity(0.3),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusHeader(theme, isConnected),
              const SizedBox(height: 24),
              if (isConnected) ...[
                _buildLiveStats(theme),
                const SizedBox(height: 24),
                _buildJoystickMonitor(theme),
              ] else ...[
                _buildConnectionGuide(theme),
              ],
              const SizedBox(height: 32),
              if (!isConnected)
                FilledButton.icon(
                  onPressed: _isConnecting ? null : _handleConnect,
                  icon: _isConnecting 
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.bluetooth_connected),
                  label: Text(_isConnecting ? 'Connecting...' : 'Connect to Bike'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader(ThemeData theme, bool isConnected) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isConnected 
          ? Colors.green.withOpacity(0.1) 
          : theme.colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isConnected ? Colors.green.withOpacity(0.3) : theme.colorScheme.error.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            isConnected ? Icons.check_circle : Icons.warning_rounded,
            size: 48,
            color: isConnected ? Colors.green : theme.colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            isConnected ? 'Dashboard Connected' : 'Dashboard Offline',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            isConnected ? 'Receiving live telemetry' : 'Connect to access bike data',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveStats(ThemeData theme) {
    final speed = _telemetry.length > 5 ? _telemetry[4] : 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LIVE TELEMETRY', style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.2)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                theme, 
                'Speed', 
                '$speed', 
                'km/h', 
                Icons.speed,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                theme, 
                'Packets', 
                '${_telemetry.length}', 
                'bytes', 
                Icons.data_usage,
                Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String label, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildJoystickMonitor(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.gamepad_outlined, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Joystick Monitor', style: theme.textTheme.titleMedium),
                Text(
                  _lastButton != null 
                    ? 'Last event: 0x${_lastButton!.toRadixString(16).toUpperCase()}' 
                    : 'Waiting for input...',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (_lastButton != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ACTIVE',
                style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConnectionGuide(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('HOW TO CONNECT', style: theme.textTheme.labelLarge),
            const SizedBox(height: 16),
            _guideStep(Icons.wifi, 'Turn on Bike Wi-Fi', 'Ensure your Himalayan 450 dashboard Wi-Fi is active.'),
            _guideStep(Icons.phonelink_setup, 'Connect Phone', 'Connect your phone to the "RE_Himalayan" hotspot.'),
            _guideStep(Icons.touch_app, 'Tap Connect', 'Tap the button below to start the K1G handshake.'),
          ],
        ),
      ),
    );
  }

  Widget _guideStep(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
