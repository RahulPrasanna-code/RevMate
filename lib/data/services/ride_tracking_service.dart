import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../database/database.dart';
import '../providers.dart';

final rideTrackingServiceProvider = StateNotifierProvider<RideTrackingService, RideTrackingState>((ref) {
  return RideTrackingService(ref);
});

class RideTrackingState {
  final bool isTracking;
  final List<LatLng> routePoints;
  final DateTime? startTime;
  final double distanceKm;

  RideTrackingState({
    this.isTracking = false,
    this.routePoints = const [],
    this.startTime,
    this.distanceKm = 0.0,
  });

  RideTrackingState copyWith({
    bool? isTracking,
    List<LatLng>? routePoints,
    DateTime? startTime,
    double? distanceKm,
  }) {
    return RideTrackingState(
      isTracking: isTracking ?? this.isTracking,
      routePoints: routePoints ?? this.routePoints,
      startTime: startTime ?? this.startTime,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }
}

class RideTrackingService extends StateNotifier<RideTrackingState> {
  final Ref _ref;
  StreamSubscription<Position>? _positionSubscription;

  RideTrackingService(this._ref) : super(RideTrackingState());

  Future<void> startRide() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    state = RideTrackingState(
      isTracking: true,
      startTime: DateTime.now(),
      routePoints: [],
      distanceKm: 0.0,
    );

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      final newPoint = LatLng(position.latitude, position.longitude);
      final updatedPoints = [...state.routePoints, newPoint];
      
      double addedDistance = 0.0;
      if (state.routePoints.isNotEmpty) {
        final lastPoint = state.routePoints.last;
        addedDistance = Geolocator.distanceBetween(
          lastPoint.latitude,
          lastPoint.longitude,
          newPoint.latitude,
          newPoint.longitude,
        ) / 1000.0; // Convert to km
      }

      state = state.copyWith(
        routePoints: updatedPoints,
        distanceKm: state.distanceKm + addedDistance,
      );
    });
  }

  Future<void> stopRide(int bikeId, int startOdometer) async {
    if (!state.isTracking) return;

    _positionSubscription?.cancel();
    final endTime = DateTime.now();
    final db = _ref.read(dbProvider);

    final routePointsJson = jsonEncode(
      state.routePoints.map((p) => {'lat': p.latitude, 'lng': p.longitude}).toList(),
    );

    final rideLog = RideLogData(
      id: 0,
      bikeId: bikeId,
      startTime: state.startTime!,
      endTime: endTime,
      distanceKm: state.distanceKm,
      routePoints: routePointsJson,
      startOdometer: startOdometer,
      endOdometer: startOdometer + state.distanceKm.toInt(),
    );

    await db.insertRideLog(rideLog);
    
    // Update bike odometer
    final bikes = await db.watchAllBikes().first;
    if (bikes.isNotEmpty) {
      final bike = bikes.firstWhere((b) => b.id == bikeId);
      await db.insertOrUpdateBike(bike.copyWith(
        currentOdometer: bike.currentOdometer + state.distanceKm.toInt(),
      ));
    }

    state = RideTrackingState(isTracking: false);
  }
}
