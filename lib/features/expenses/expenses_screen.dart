import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(watchAllBikesProvider);
    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) return _emptyState(context);
        final bikeId = bikes.first.id;
        final logsAsync = ref.watch(watchExpenseLogsByBikeProvider(bikeId));
        return Scaffold(
          body: logsAsync.when(
            data: (logs) {
              if (logs.isEmpty) return _emptyList(context);
              final grouped = <String, List<ExpenseLogData>>{};
              for (final l in logs) {
                final key = DateFormat.yMMM().format(l.date);
                grouped.putIfAbsent(key, () => []).add(l);
              }
              return ListView(
                padding: const EdgeInsets.all(12),
                children: grouped.entries.map((e) {
                  final total = e.value.fold(0.0, (s, i) => s + i.cost);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${e.key} — ₹ ${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ...e.value.map(
                        (item) => Card(
                          child: ListTile(
                            title: Text(DateFormat.yMMMd().format(item.date)),
                            subtitle: Text(item.description),
                            trailing: Text('₹ ${item.cost.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAdd(context, bikeId),
            label: const Text('Add Expense'),
            icon: const Icon(Icons.receipt_long),
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
          Icons.receipt_long,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text('No bike found', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Add a bike in Profile to start logging expenses.',
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
          Icons.receipt_long,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(
          'No expense records yet',
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
        child: ExpenseAddSheet(bikeId: bikeId),
      ),
    );
  }
}

class ExpenseAddSheet extends ConsumerStatefulWidget {
  final int bikeId;
  const ExpenseAddSheet({required this.bikeId, super.key});

  @override
  ConsumerState<ExpenseAddSheet> createState() => _ExpenseAddSheetState();
}

class _ExpenseAddSheetState extends ConsumerState<ExpenseAddSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String _category = 'parts';
  final _desc = TextEditingController();
  final _cost = TextEditingController();

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
            DropdownButtonFormField<String>(
              value: _category,
              items: const [
                DropdownMenuItem(value: 'parts', child: Text('Parts')),
                DropdownMenuItem(value: 'accessory', child: Text('Accessory')),
                DropdownMenuItem(value: 'repair', child: Text('Repair')),
                DropdownMenuItem(value: 'insurance', child: Text('Insurance')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: (v) => setState(() => _category = v ?? 'parts'),
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
    final categoryEnum = ExpenseCategory.values.firstWhere(
      (e) => e.value == _category,
      orElse: () => ExpenseCategory.other,
    );
    final entry = ExpenseLogsCompanion.insert(
      bikeId: widget.bikeId,
      date: _date,
      category: categoryEnum,
      description: _desc.text,
      cost: double.tryParse(_cost.text) ?? 0.0,
    );
    await db.into(db.expenseLogs).insert(entry);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Expense saved')));
    }
  }
}
