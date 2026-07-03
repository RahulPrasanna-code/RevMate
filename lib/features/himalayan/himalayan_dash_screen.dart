import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    super.initState();
    final service = ref.read(himalayanDashProvider);
    service.statusStream.listen((s) => setState(() => _status = s));
    service.telemetryStream.listen((t) => setState(() => _telemetry = t));
    service.buttonStream.listen((b) => setState(() => _lastButton = b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Himalayan 450 Dash')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _statusCard(),
            const SizedBox(height: 16),
            _telemetryCard(),
            const SizedBox(height: 16),
            _buttonCard(),
            const Spacer(),
            ElevatedButton(
              onPressed: () => ref.read(himalayanDashProvider).connect('RE_Himalayan'),
              child: const Text('Connect to Himalayan'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.read(himalayanDashProvider).disconnect(),
              child: const Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Connection Status', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(_status, style: TextStyle(
              fontSize: 24, 
              color: _status == 'connected' ? Colors.green : Colors.red
            )),
          ],
        ),
      ),
    );
  }

  Widget _telemetryCard() {
    // Basic telemetry mapping based on common patterns
    // Speed is often in the first few bytes, RPM follows, etc.
    final speed = _telemetry.length > 5 ? _telemetry[4] : 0;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Live Telemetry', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _stat('Speed', '$speed km/h'),
                _stat('Data Pkts', '${_telemetry.length} bytes'),
              ],
            ),
            if (_telemetry.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Raw: ${_telemetry.take(10).join(", ")}...', style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buttonCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Last Joystick Event', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(_lastButton != null ? 'Button Code: 0x${_lastButton!.toRadixString(16).padLeft(2, "0")}' : 'None', 
                 style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
