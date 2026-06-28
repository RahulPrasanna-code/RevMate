import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'vehicle_lookup.dart';
// intl not used here

class BikeProfileScreen extends ConsumerWidget {
  const BikeProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(watchAllBikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) return _emptyProfile(context);
        final bike = bikes.first;
        return _profileView(context, ref, bike);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _emptyProfile(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.two_wheeler,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text('No bike found', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => _showEditSheet(context),
              child: const Text('Add Manually'),
            ),
            const SizedBox(width: 8),
            FilledButton.tonal(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VehicleLookupPage()),
              ),
              child: const Text('Lookup by Plate'),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _profileView(BuildContext context, WidgetRef ref, BikeData bike) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bike.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('${bike.make} ${bike.model} — ${bike.year}'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _expiryChip(context, 'Insurance', bike.insuranceExpiry),
              _expiryChip(context, 'PUC', bike.pucExpiry),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton(
                onPressed: () => _showEditSheet(context, bike: bike),
                child: const Text('Edit'),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VehicleLookupPage()),
                ),
                child: const Text('Import from RC'),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showSettings(context),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: ApiKeySettingsSheet(),
      ),
    );
  }

  Widget _expiryChip(BuildContext context, String label, DateTime expiry) {
    final days = expiry.difference(DateTime.now()).inDays;
    final isUrgent = days <= 30;
    return Chip(
      label: Text('$label: $days days left'),
      backgroundColor: isUrgent
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.secondaryContainer,
    );
  }

  void _showEditSheet(BuildContext context, {BikeData? bike}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: BikeEditSheet(bike: bike),
      ),
    );
  }
}

class ApiKeySettingsSheet extends ConsumerStatefulWidget {
  const ApiKeySettingsSheet({super.key});

  @override
  ConsumerState<ApiKeySettingsSheet> createState() =>
      _ApiKeySettingsSheetState();
}

class _ApiKeySettingsSheetState extends ConsumerState<ApiKeySettingsSheet> {
  final _anthropic = TextEditingController();
  final _rapid = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final a = await _storage.read(key: 'anthropic_key');
    final r = await _storage.read(key: 'rapidapi_key');
    if (mounted)
      setState(() {
        _anthropic.text = a ?? '';
        _rapid.text = r ?? '';
      });
  }

  Future<void> _save() async {
    await _storage.write(key: 'anthropic_key', value: _anthropic.text.trim());
    await _storage.write(key: 'rapidapi_key', value: _rapid.text.trim());
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('API keys saved')));
  }

  @override
  void dispose() {
    _anthropic.dispose();
    _rapid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _anthropic,
            decoration: const InputDecoration(labelText: 'Anthropic API Key'),
          ),
          TextFormField(
            controller: _rapid,
            decoration: const InputDecoration(labelText: 'RapidAPI Key'),
          ),
          const SizedBox(height: 12),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
    );
  }
}

class BikeEditSheet extends ConsumerStatefulWidget {
  final BikeData? bike;
  const BikeEditSheet({this.bike, super.key});

  @override
  ConsumerState<BikeEditSheet> createState() => _BikeEditSheetState();
}

class _BikeEditSheetState extends ConsumerState<BikeEditSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _make;
  late final TextEditingController _model;
  late final TextEditingController _year;
  late final TextEditingController _odometer;
  DateTime? _insurance;
  DateTime? _puc;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.bike?.name ?? '');
    _make = TextEditingController(text: widget.bike?.make ?? '');
    _model = TextEditingController(text: widget.bike?.model ?? '');
    _year = TextEditingController(text: widget.bike?.year.toString() ?? '');
    _odometer = TextEditingController(
      text: widget.bike?.currentOdometer.toString() ?? '0',
    );
    _insurance =
        widget.bike?.insuranceExpiry ??
        DateTime.now().add(const Duration(days: 365));
    _puc =
        widget.bike?.pucExpiry ?? DateTime.now().add(const Duration(days: 365));
  }

  @override
  void dispose() {
    _name.dispose();
    _make.dispose();
    _model.dispose();
    _year.dispose();
    _odometer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _make,
              decoration: const InputDecoration(labelText: 'Make'),
            ),
            TextFormField(
              controller: _model,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            TextFormField(
              controller: _year,
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _odometer,
              decoration: const InputDecoration(labelText: 'Current Odometer'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton(
                  onPressed: _pickInsurance,
                  child: const Text('Pick Insurance Date'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _pickPuc,
                  child: const Text('Pick PUC Date'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _save,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickInsurance() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _insurance ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _insurance = d);
  }

  Future<void> _pickPuc() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _puc ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _puc = d);
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final bike = BikeData(
      id: widget.bike?.id ?? 0,
      name: _name.text,
      make: _make.text,
      model: _model.text,
      year: int.tryParse(_year.text) ?? 0,
      currentOdometer: int.tryParse(_odometer.text) ?? 0,
      insuranceExpiry: _insurance!,
      pucExpiry: _puc!,
      photoPath: widget.bike?.photoPath,
    );
    await db.insertOrUpdateBike(bike);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bike saved')));
    }
  }
}
