import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';
import '../../data/services/notification_service.dart';
import '../../data/services/ai_manager_service.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String? _nudge;
  bool _loadingNudge = false;

  @override
  void initState() {
    super.initState();
    _fetchNudge();
  }

  Future<void> _fetchNudge() async {
    setState(() => _loadingNudge = true);
    final nudge = await ref.read(aiManagerProvider).getNudge();
    if (mounted) {
      setState(() {
        _nudge = nudge;
        _loadingNudge = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bikesAsync = ref.watch(watchAllBikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) {
          return _emptyState(context);
        }
        final bike = bikes.first;
        final bikeId = bike.id;

        final fuelLogsAsync = ref.watch(watchFuelLogsByBikeProvider(bikeId));
        final serviceLogsAsync = ref.watch(
          watchServiceLogsByBikeProvider(bikeId),
        );
        final expenseLogsAsync = ref.watch(
          watchExpenseLogsByBikeProvider(bikeId),
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_nudge != null && _nudge!.isNotEmpty) _nudgeBanner(context),
              const SizedBox(height: 8),
              Text(
                'Hello, ${bike.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _odometerCard(context, bike),
                  _nextServiceCard(context, serviceLogsAsync),
                  _monthlySpendCard(context, fuelLogsAsync, expenseLogsAsync),
                  _avgFuelEfficiencyCard(context, fuelLogsAsync),
                  _tyrePressureCard(context, ref),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _nudgeBanner(BuildContext context) {
    return MaterialBanner(
      content: Text(_nudge!),
      leading: const Icon(Icons.tips_and_updates),
      actions: [
        TextButton(
          onPressed: () => setState(() => _nudge = null),
          child: const Text('DISMISS'),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }

  Widget _emptyState(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.two_wheeler,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'No bike set up yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Please add your bike details in Profile.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget _odometerCard(BuildContext context, BikeData bike) {
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Odometer',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${bike.currentOdometer} km',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nextServiceCard(
    BuildContext context,
    AsyncValue<List<ServiceLogData>> serviceLogsAsync,
  ) {
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: serviceLogsAsync.when(
            data: (logs) {
              if (logs.isEmpty)
                return Text(
                  'No service records',
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              final latest = logs.first;
              final nextDueDate = latest.nextDueDate;
              final days = nextDueDate == null
                  ? null
                  : nextDueDate.difference(DateTime.now()).inDays;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Service',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  if (nextDueDate != null)
                    Text(
                      '${days ?? '-'} days (${DateFormat.yMMMd().format(nextDueDate)})',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  else
                    Text(
                      'No due date set',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              );
            },
            loading: () => const SizedBox(
              height: 48,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, st) =>
                Text('Error', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }

  Widget _monthlySpendCard(
    BuildContext context,
    AsyncValue<List<FuelLogData>> fuelLogsAsync,
    AsyncValue<List<ExpenseLogData>> expenseLogsAsync,
  ) {
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This Month Spend',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Builder(
                builder: (ctx) {
                  if (fuelLogsAsync.isLoading || expenseLogsAsync.isLoading)
                    return const CircularProgressIndicator();
                  final monthStart = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  );
                  double total = 0;
                  fuelLogsAsync.whenData((logs) {
                    total += logs
                        .where((l) => l.date.isAfter(monthStart))
                        .fold(0.0, (s, e) => s + (e.costTotal ?? 0));
                  });
                  expenseLogsAsync.whenData((logs) {
                    total += logs
                        .where((l) => l.date.isAfter(monthStart))
                        .fold(0.0, (s, e) => s + (e.cost));
                  });
                  return Text(
                    '₹ ${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avgFuelEfficiencyCard(
    BuildContext context,
    AsyncValue<List<FuelLogData>> fuelLogsAsync,
  ) {
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: fuelLogsAsync.when(
            data: (logs) {
              // compute avg km/l over last 5 full tank entries
              final fulls = logs.where((l) => l.fullTank).toList();
              if (fulls.length < 2)
                return Text(
                  'Not enough data',
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              double totalKm = 0;
              double totalLiters = 0;
              for (var i = 0; i < fulls.length - 1 && i < 5; i++) {
                final cur = fulls[i];
                final prev = fulls[i + 1];
                final km = (cur.odometer - prev.odometer).toDouble();
                totalKm += km;
                totalLiters += cur.liters;
              }
              final avg = totalLiters > 0 ? totalKm / totalLiters : 0.0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avg Fuel Efficiency',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${avg.toStringAsFixed(2)} km/l',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              );
            },
            loading: () => const SizedBox(
              height: 48,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, st) =>
                Text('Error', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }

  Widget _tyrePressureCard(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tyre Pressure',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Check every 15 days',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  FilledButton.tonal(
                    onPressed: () async {
                      final svc = ref.read(notificationServiceProvider);
                      await svc.markTyreChecked();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tyre pressure check recorded!')),
                        );
                      }
                    },
                    child: const Text('Mark Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
