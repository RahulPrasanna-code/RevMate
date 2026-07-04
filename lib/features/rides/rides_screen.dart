import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../data/services/ride_tracking_service.dart';
import '../../data/providers.dart';
import '../../data/database/database.dart';
import 'package:intl/intl.dart';

class RidesScreen extends ConsumerWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final trackingState = ref.watch(rideTrackingServiceProvider);
    final bikesAsync = ref.watch(watchAllBikesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rides'),
        actions: [
          if (trackingState.isTracking)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: _buildLiveIndicator(),
            ),
        ],
      ),
      body: bikesAsync.when(
        data: (bikes) {
          if (bikes.isEmpty) return _buildEmptyBikes(context);
          final bike = bikes.first;

          return Column(
            children: [
              if (trackingState.isTracking)
                _buildActiveRideCard(context, ref, trackingState, bike)
              else
                _buildStartRideCard(context, ref, bike),
              
              Expanded(
                child: _buildRideHistoryList(context, ref, bike.id),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildLiveIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: Colors.white),
          SizedBox(width: 4),
          Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActiveRideCard(BuildContext context, WidgetRef ref, RideTrackingState state, BikeData bike) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rideStat(theme, 'Distance', '${state.distanceKm.toStringAsFixed(1)}', 'km'),
              _rideStat(theme, 'Points', '${state.path.length}', 'pts'),
              IconButton.filled(
                onPressed: () => ref.read(rideTrackingServiceProvider.notifier).stopRide(bike.id, bike.currentOdometer),
                icon: const Icon(Icons.stop),
                style: IconButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: state.path.isNotEmpty ? state.path.last : const LatLng(0, 0),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.revmate.app',
                  ),
                  if (state.path.length >= 2)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.path,
                          color: theme.colorScheme.primary,
                          strokeWidth: 4,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartRideCard(BuildContext context, WidgetRef ref, BikeData bike) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.route, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Ready for a new adventure?',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => ref.read(rideTrackingServiceProvider.notifier).startRide(),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Start Tracking Ride', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRideHistoryList(BuildContext context, WidgetRef ref, int bikeId) {
    final theme = Theme.of(context);
    final ridesAsync = ref.watch(watchRideLogsByBikeProvider(bikeId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text('RECENT RIDES', style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.2)),
        ),
        Expanded(
          child: ridesAsync.when(
            data: (rides) {
              if (rides.isEmpty) return _buildEmptyHistory(theme);
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  final ride = rides[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.history, color: theme.colorScheme.primary),
                      ),
                      title: Text(DateFormat.yMMMd().add_jm().format(ride.startTime)),
                      subtitle: Text('${ride.distanceKm.toStringAsFixed(1)} km'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showRideDetails(context, ride),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyBikes(BuildContext context) => const Center(child: Text('Add a bike first'));

  Widget _buildEmptyHistory(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.map_outlined, size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text('No rides recorded yet', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _rideStat(ThemeData theme, String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 2),
              Text(unit, style: const TextStyle(fontSize: 12)),
            ],
          ],
        ),
      ],
    );
  }

  void _showRideDetails(BuildContext context, RideLogData ride) {
    // Show ride details/map implementation
  }
}
