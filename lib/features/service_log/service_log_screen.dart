import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';
import 'package:drift/drift.dart' as d;
import 'package:intl/intl.dart';

class ServiceLogScreen extends ConsumerWidget {
  const ServiceLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(watchAllBikesProvider);
    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) return _emptyState(context);
        final bikeId = bikes.first.id;
        final logsAsync = ref.watch(watchServiceLogsByBikeProvider(bikeId));
        return Scaffold(
          body: logsAsync.when(
            data: (logs) {
              if (logs.isEmpty) return _emptyList(context);
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: logs.length,
                itemBuilder: (ctx, i) {
                  final l = logs[i];
                  return Card(
                    child: ListTile(
                      title: Text(DateFormat.yMMMd().format(l.date)),
                      subtitle: Text('${l.serviceType} • Odo: ${l.odometer}'),
                      trailing: Text('₹ ${l.cost.toStringAsFixed(2)}'),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAdd(context, bikeId),
            label: const Text('Add Service'),
            icon: const Icon(Icons.build),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _emptyState(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.build,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text('No bike found', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Add a bike in Profile to record services.',
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
          Icons.build,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(
          'No service records yet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );

  void _showAdd(BuildContext context, int bikeId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: ServiceAddSheet(bikeId: bikeId),
      ),
    );
  }
}

class ServiceAddSheet extends ConsumerStatefulWidget {
  final int bikeId;
  const ServiceAddSheet({required this.bikeId, super.key});

  @override
  ConsumerState<ServiceAddSheet> createState() => _ServiceAddSheetState();
}

class _ServiceAddSheetState extends ConsumerState<ServiceAddSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _odometer = TextEditingController();
  final _type = TextEditingController();
  final _desc = TextEditingController();
  final _cost = TextEditingController();
  final _nextOdo = TextEditingController();
  DateTime? _nextDate;

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
            ),
            TextFormField(
              controller: _type,
              decoration: const InputDecoration(labelText: 'Service Type'),
            ),
            TextFormField(
              controller: _desc,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _cost,
              decoration: const InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _nextOdo,
              decoration: const InputDecoration(labelText: 'Next Due Odometer'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                FilledButton(
                  onPressed: _pickNextDate,
                  child: const Text('Pick Next Date'),
                ),
                const Spacer(),
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

  Future<void> _pickNextDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _nextDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _nextDate = d);
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final entry = ServiceLogsCompanion.insert(
      bikeId: widget.bikeId,
      date: _date,
      odometer: int.tryParse(_odometer.text) ?? 0,
      serviceType: _type.text,
      description: _desc.text,
      cost: double.tryParse(_cost.text) ?? 0.0,
      nextDueOdometer: d.Value(
        _nextOdo.text.isEmpty ? null : int.tryParse(_nextOdo.text),
      ),
      nextDueDate: d.Value(_nextDate),
    );
    await db.into(db.serviceLogs).insert(entry);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Service saved')));
    }
  }
}
