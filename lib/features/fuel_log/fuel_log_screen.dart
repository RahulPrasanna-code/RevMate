import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as d;
import '../../data/providers.dart';
import '../../data/database/database.dart';
import 'package:intl/intl.dart';

class FuelLogScreen extends ConsumerWidget {
  const FuelLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(watchAllBikesProvider);
    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) return _emptyState(context);
        final bikeId = bikes.first.id;
        final logsAsync = ref.watch(watchFuelLogsByBikeProvider(bikeId));
        return Scaffold(
          body: logsAsync.when(
            data: (logs) {
              if (logs.isEmpty) return _emptyList(context);
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: logs.length,
                itemBuilder: (ctx, i) {
                  final l = logs[i];
                  final kmPerLiter = _calcKmPerLiter(logs, i);
                  return Card(
                    child: ListTile(
                      title: Text(DateFormat.yMMMd().format(l.date)),
                      subtitle: Text(
                        'Odo: ${l.odometer} • ${l.liters} L • ₹ ${l.costTotal.toStringAsFixed(2)}',
                      ),
                      trailing: Text(
                        kmPerLiter != null
                            ? '${kmPerLiter.toStringAsFixed(2)} km/l'
                            : '-',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddSheet(context, bikeId),
            label: const Text('Add Fuel'),
            icon: const Icon(Icons.local_gas_station),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  double? _calcKmPerLiter(List<FuelLogData> logs, int index) {
    // compute km/l between this full tank and previous full tank
    final current = logs[index];
    if (!current.fullTank) return null;
    for (int j = index + 1; j < logs.length; j++) {
      final prev = logs[j];
      if (prev.fullTank) {
        final km = (current.odometer - prev.odometer).toDouble();
        return km / current.liters;
      }
    }
    return null;
  }

  Widget _emptyState(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_gas_station,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text('No bike found', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Add a bike in Profile to start logging fuel.',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _emptyList(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_gas_station,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(
          'No fuel logs yet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );

  void _showAddSheet(BuildContext context, int bikeId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: FuelAddSheet(bikeId: bikeId),
      ),
    );
  }
}

class FuelAddSheet extends ConsumerStatefulWidget {
  final int bikeId;
  const FuelAddSheet({required this.bikeId, super.key});

  @override
  ConsumerState<FuelAddSheet> createState() => _FuelAddSheetState();
}

class _FuelAddSheetState extends ConsumerState<FuelAddSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _odometer = TextEditingController();
  final _liters = TextEditingController();
  final _cost = TextEditingController();
  bool _full = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Date: ${DateFormat.yMMMd().format(_date)}'),
                const Spacer(),
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            TextFormField(
              controller: _odometer,
              decoration: const InputDecoration(labelText: 'Odometer'),
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _liters,
              decoration: const InputDecoration(labelText: 'Liters'),
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _cost,
              decoration: const InputDecoration(labelText: 'Total Cost'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Checkbox(
                  value: _full,
                  onChanged: (v) => setState(() => _full = v ?? true),
                ),
                const Text('Full tank'),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _date = d);
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final log = FuelLogsCompanion.insert(
      bikeId: widget.bikeId,
      date: _date,
      odometer: int.parse(_odometer.text),
      liters: double.parse(_liters.text),
      costTotal: double.tryParse(_cost.text) ?? 0.0,
      costPerLiter: (_cost.text.isEmpty)
          ? 0.0
          : (double.parse(_cost.text) / double.parse(_liters.text)),
      fullTank: d.Value(_full),
    );
    await db.into(db.fuelLogs).insert(log);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Fuel log saved')));
    }
  }
}
