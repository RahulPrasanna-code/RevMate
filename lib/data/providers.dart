import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database.dart';

final dbProvider = Provider<RevMateDatabase>((ref) {
  final db = RevMateDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final watchAllBikesProvider = StreamProvider<List<BikeData>>((ref) {
  final db = ref.watch(dbProvider);
  return db.watchAllBikes();
});

final watchBikeByIdProvider = StreamProvider.family<BikeData?, int>((ref, id) {
  final db = ref.watch(dbProvider);
  return db.watchBikeById(id);
});

final watchFuelLogsByBikeProvider =
    StreamProvider.family<List<FuelLogData>, int>((ref, bikeId) {
      final db = ref.watch(dbProvider);
      return db.watchFuelLogsOrderedByDate(bikeId);
    });

final watchServiceLogsByBikeProvider =
    StreamProvider.family<List<ServiceLogData>, int>((ref, bikeId) {
      final db = ref.watch(dbProvider);
      return db.watchServiceLogsOrderedByDate(bikeId);
    });

final watchExpenseLogsByBikeProvider =
    StreamProvider.family<List<ExpenseLogData>, int>((ref, bikeId) {
      final db = ref.watch(dbProvider);
      return db.watchExpenseLogsOrderedByDate(bikeId);
    });

final watchRideLogsByBikeProvider =
    StreamProvider.family<List<RideLogData>, int>((ref, bikeId) {
      final db = ref.watch(dbProvider);
      return db.watchRideLogsOrderedByDate(bikeId);
    });
