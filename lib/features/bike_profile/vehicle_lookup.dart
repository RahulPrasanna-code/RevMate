import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/services/vehicle_lookup_service.dart';
import '../../shared/utils/date_parser.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';

class VehicleLookupPage extends ConsumerStatefulWidget {
  const VehicleLookupPage({super.key});

  @override
  ConsumerState<VehicleLookupPage> createState() => _VehicleLookupPageState();
}

class _VehicleLookupPageState extends ConsumerState<VehicleLookupPage> {
  final _plateCtl = TextEditingController();
  bool _loading = false;
  VehicleDetails? _details;
  String? _debugInfo;
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _plateCtl.dispose();
    super.dispose();
  }

  String _cleanPlate(String s) =>
      s.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

  Future<void> _lookup() async {
    final plate = _cleanPlate(_plateCtl.text);
    if (plate.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a valid plate')));
      return;
    }
    setState(() {
      _loading = true;
      _debugInfo = null;
    });
    try {
      // Prefer env var RAPIDAPI_KEY if dotenv is initialized, otherwise fall back to secure storage
      final envKey = dotenv.isInitialized ? dotenv.env['RAPIDAPI_KEY'] : null;
      final rapidKey = envKey?.isNotEmpty == true
          ? envKey
          : await _storage.read(key: 'rapidapi_key');
      if (rapidKey == null || rapidKey.isEmpty) throw Exception('missing_key');
      final headers = {
        'Content-Type': 'application/json',
        'x-rapidapi-key': rapidKey,
        'x-rapidapi-host': 'vehicle-rc-information-v2.p.rapidapi.com',
      };
      print('VehicleLookupPage: starting lookup for plate $plate');
      final svc = VehicleLookupService();
      final v = await svc.lookupByPlate(plate, headers, parseIndianDate);
      if (!mounted) return;
      if (v == null) {
        setState(
          () => _debugInfo = 'Response did not contain vehicle details.',
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Vehicle not found')));
        return;
      }
      setState(() {
        _details = v;
        _debugInfo = null;
      });
    } catch (e) {
      if (!mounted) return;
      final details = e.toString();
      final msg = _lookupErrorMessage(details);
      setState(() => _debugInfo = details);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _lookupErrorMessage(String details) {
    if (details.contains('missing_key')) {
      return 'Missing RapidAPI key';
    }
    if (details.contains('TimeoutException')) {
      return 'Lookup timed out';
    }
    final httpMatch = RegExp(r'HTTP\s*(\d+):\s*(.*)').firstMatch(details);
    if (httpMatch != null) {
      final status = httpMatch.group(1);
      final body = httpMatch.group(2)?.trim();
      if (status == '429') {
        return 'Quota exceeded. Please upgrade or try again later.';
      }
      if (status == '502') {
        return 'Service unavailable. Please try again later.';
      }
      if (body != null && body.isNotEmpty) {
        return 'Lookup failed ($status): ${body.length > 80 ? '${body.substring(0, 80)}...' : body}';
      }
      return 'Lookup failed ($status)';
    }
    return 'Lookup failed: ${details.replaceAll('\n', ' ')}';
  }

  Future<void> _saveAsBike(VehicleDetails details) async {
    final db = ref.read(dbProvider);
    final existingBikes = await db.watchAllBikes().first;
    final bike = BikeData(
      id: existingBikes.isNotEmpty ? existingBikes.first.id : 0,
      name: '${details.make ?? ''} ${details.model ?? ''}'.trim(),
      make: details.make ?? '',
      model: details.model ?? '',
      year: details.year ?? 0,
      currentOdometer: 0,
      insuranceExpiry:
          details.insuranceExpiry ??
          DateTime.now().add(const Duration(days: 365)),
      pucExpiry:
          details.pucExpiry ?? DateTime.now().add(const Duration(days: 365)),
      photoPath: null,
    );
    await db.insertOrUpdateBike(bike);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Bike added from RC')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lookup by Plate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _details == null ? _buildLookup() : _buildConfirm(),
      ),
    );
  }

  Widget _buildLookup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _plateCtl,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Registration Number',
            hintText: 'TN09AB1234',
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: _loading ? null : _lookup,
          child: _loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Lookup Vehicle'),
        ),
        if (_debugInfo != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Error: $_debugInfo',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Enter Manually'),
        ),
      ],
    );
  }

  Widget _buildConfirm() {
    final d = _details!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto-filled from RTO',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Reg: ${d.registrationNumber}'),
                  Text('Make: ${d.make ?? '-'}'),
                  Text('Model: ${d.model ?? '-'}'),
                  Text('Year: ${d.year ?? '-'}'),
                  Text('Fuel: ${d.fuelType ?? '-'}'),
                  Text('Engine CC: ${d.engineCC ?? '-'}'),
                  Text('Colour: ${d.colour ?? '-'}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => _saveAsBike(_details!),
            child: const Text('Save Bike'),
          ),
        ],
      ),
    );
  }
}
