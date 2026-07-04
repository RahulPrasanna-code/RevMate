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
    final theme = Theme.of(context);
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

        return RefreshIndicator(
          onRefresh: _fetchNudge,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_nudge != null && _nudge!.isNotEmpty) ...[
                  _nudgeBanner(context),
                  const SizedBox(height: 24),
                ],
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(Icons.two_wheeler, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Rider',
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        Text(
                          bike.name,
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('BIKE STATUS', style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.2)),
                const SizedBox(height: 16),
                _buildStatusGrid(context, bike, serviceLogsAsync, fuelLogsAsync, expenseLogsAsync),
                const SizedBox(height: 32),
                Text('MAINTENANCE', style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.2)),
                const SizedBox(height: 16),
                _tyrePressureCard(context, ref),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildStatusGrid(
    BuildContext context, 
    BikeData bike,
    AsyncValue<List<ServiceLogData>> serviceLogs,
    AsyncValue<List<FuelLogData>> fuelLogs,
    AsyncValue<List<ExpenseLogData>> expenseLogs,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _statCard(context, 'Odometer', '${bike.currentOdometer}', 'km', Icons.speed, Colors.blue),
        _nextServiceCard(context, serviceLogs),
        _monthlySpendCard(context, fuelLogs, expenseLogs),
        _avgFuelEfficiencyCard(context, fuelLogs),
      ],
    );
  }

  Widget _statCard(BuildContext context, String label, String value, String unit, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          Text('$label ($unit)', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _nudgeBanner(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _nudge!,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _nudge = null),
            icon: const Icon(Icons.close, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.two_wheeler,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Ready for a ride?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your bike details to start tracking maintenance and fuel.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    ),
  );

  Widget _nextServiceCard(
    BuildContext context,
    AsyncValue<List<ServiceLogData>> serviceLogsAsync,
  ) {
    return serviceLogsAsync.when(
      data: (logs) {
        String value = 'N/A';
        String label = 'Next Service';
        if (logs.isNotEmpty) {
          final nextDueDate = logs.first.nextDueDate;
          if (nextDueDate != null) {
            final days = nextDueDate.difference(DateTime.now()).inDays;
            value = '$days';
            label = 'Days to Service';
          }
        }
        return _statCard(context, label, value, 'days', Icons.build_circle, Colors.orange);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => _statCard(context, 'Service', 'Error', '', Icons.error, Colors.red),
    );
  }

  Widget _monthlySpendCard(
    BuildContext context,
    AsyncValue<List<FuelLogData>> fuelLogsAsync,
    AsyncValue<List<ExpenseLogData>> expenseLogsAsync,
  ) {
    final theme = Theme.of(context);
    if (fuelLogsAsync.isLoading || expenseLogsAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final monthStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
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

    return _statCard(context, 'Month Spend', '₹${total.toInt()}', 'INR', Icons.account_balance_wallet, Colors.green);
  }

  Widget _avgFuelEfficiencyCard(
    BuildContext context,
    AsyncValue<List<FuelLogData>> fuelLogsAsync,
  ) {
    return fuelLogsAsync.when(
      data: (logs) {
        final fulls = logs.where((l) => l.fullTank).toList();
        double avg = 0;
        if (fulls.length >= 2) {
          double totalKm = 0;
          double totalLiters = 0;
          for (var i = 0; i < fulls.length - 1 && i < 5; i++) {
            totalKm += (fulls[i].odometer - fulls[i + 1].odometer).toDouble();
            totalLiters += fulls[i].liters;
          }
          avg = totalLiters > 0 ? totalKm / totalLiters : 0.0;
        }
        return _statCard(context, 'Efficiency', avg > 0 ? avg.toStringAsFixed(1) : 'N/A', 'km/l', Icons.local_gas_station, Colors.purple);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => _statCard(context, 'Fuel', 'Error', '', Icons.error, Colors.red),
    );
  }

  Widget _tyrePressureCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.tire_repair, color: theme.colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tyre Pressure', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text('Check every 15 days', style: theme.textTheme.bodySmall),
              ],
            ),
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
    );
  }
}
