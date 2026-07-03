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
    final trackingState = ref.watch(rideTrackingServiceProvider);
    final bikesAsync = ref.watch(watchAllBikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) return const Center(child: Text('Add a bike first'));
        final bike = bikes.first;

        return Column(
          children: [
            if (trackingState.isTracking) _activeRideCard(context, ref, trackingState, bike),
            Expanded(child: _rideHistoryList(context, ref, bike.id)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton.icon(
                onPressed: trackingState.isTracking 
                  ? null 
                  : () => ref.read(rideTrackingServiceProvider.notifier).startRide(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start New Ride'),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _activeRideCard(BuildContext context, WidgetRef ref, RideTrackingState state, BikeData bike) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Active Ride', style: Theme.of(context).textTheme.titleMedium),
                    Text('${state.distanceKm.toStringAsFixed(2)} km', style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
                IconButton.filled(
                  onPressed: () => ref.read(rideTrackingServiceProvider.notifier).stopRide(bike.id, bike.currentOdometer),
                  icon: const Icon(Icons.stop),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rideHistoryList(BuildContext context, WidgetRef ref, int bikeId) {
    final ridesAsync = ref.watch(watchRideLogsByBikeProvider(bikeId));

    return ridesAsync.when(
      data: (rides) {
        if (rides.isEmpty) return const Center(child: Text('No rides recorded yet'));
        return ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index) {
            final ride = rides[index];
            return ListTile(
              leading: const Icon(Icons.route),
              title: Text('${ride.distanceKm.toStringAsFixed(1)} km Ride'),
              subtitle: Text(DateFormat.yMMMd().add_jm().format(ride.startTime)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showRideDetails(context, ride),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  void _showRideDetails(BuildContext context, RideLogData ride) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Ride Details', style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(0, 0),
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.yourname.revmate',
                  ),
                  // PolylineLayer would go here with parsed points
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
