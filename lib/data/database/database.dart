import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'database.g.dart';

// ============================================================================
// TABLES
// ============================================================================

@DataClassName('BikeData')
class Bikes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get make => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  IntColumn get currentOdometer => integer()();
  DateTimeColumn get insuranceExpiry => dateTime()();
  DateTimeColumn get pucExpiry => dateTime()();
  TextColumn get photoPath => text().nullable()();
}

@DataClassName('FuelLogData')
class FuelLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bikeId => integer().references(Bikes, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get odometer => integer()();
  RealColumn get liters => real()();
  RealColumn get costTotal => real()();
  RealColumn get costPerLiter => real()();
  BoolColumn get fullTank => boolean().withDefault(const Constant(false))();
}

@DataClassName('ServiceLogData')
class ServiceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bikeId => integer().references(Bikes, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get serviceType => text()();
  TextColumn get description => text()();
  RealColumn get cost => real()();
  IntColumn get nextDueOdometer => integer().nullable()();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
}

@DataClassName('ExpenseLogData')
class ExpenseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bikeId => integer().references(Bikes, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => textEnum<ExpenseCategory>()();
  TextColumn get description => text()();
  RealColumn get cost => real()();
}

enum ExpenseCategory {
  parts('parts'),
  accessory('accessory'),
  repair('repair'),
  insurance('insurance'),
  other('other');

  final String value;
  const ExpenseCategory(this.value);
}

@DataClassName('RideLogData')
class RideLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bikeId => integer().references(Bikes, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  RealColumn get distanceKm => real()();
  TextColumn get routePoints => text()(); // JSON array of lat/lng points
  IntColumn get startOdometer => integer()();
  IntColumn get endOdometer => integer()();
}

// ============================================================================
// DATABASE
// ============================================================================

@DriftDatabase(tables: [Bikes, FuelLogs, ServiceLogs, ExpenseLogs, RideLogs])
class RevMateDatabase extends _$RevMateDatabase {
  RevMateDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ============================================================================
  // BIKE OPERATIONS
  // ============================================================================

  /// Get a single bike by ID (Reactive Stream)
  Stream<BikeData?> watchBikeById(int id) =>
      (select(bikes)..where((b) => b.id.equals(id))).watchSingleOrNull();

  /// Get all bikes (Reactive Stream)
  Stream<List<BikeData>> watchAllBikes() => select(bikes).watch();

  /// Insert or update a bike
  Future<int> insertOrUpdateBike(BikeData bike) =>
      into(bikes).insertOnConflictUpdate(bike);

  /// Delete a bike
  Future<bool> deleteBike(int id) =>
      (delete(bikes)..where((b) => b.id.equals(id))).go().then((c) => c > 0);

  // ============================================================================
  // FUEL LOG OPERATIONS
  // ============================================================================

  /// Get all fuel logs for a bike (Reactive Stream)
  Stream<List<FuelLogData>> watchFuelLogsByBike(int bikeId) =>
      (select(fuelLogs)..where((f) => f.bikeId.equals(bikeId))).watch();

  /// Get fuel logs ordered by date descending (Reactive Stream)
  Stream<List<FuelLogData>> watchFuelLogsOrderedByDate(int bikeId) =>
      (select(fuelLogs)
            ..where((f) => f.bikeId.equals(bikeId))
            ..orderBy([
              (f) => OrderingTerm(expression: f.date, mode: OrderingMode.desc),
            ]))
          .watch();

  /// Get the latest full tank entry
  Future<FuelLogData?> getLatestFullTank(int bikeId) =>
      (select(fuelLogs)
            ..where((f) => f.bikeId.equals(bikeId) & f.fullTank.equals(true))
            ..orderBy([
              (f) => OrderingTerm(expression: f.date, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();

  /// Insert fuel log
  Future<int> insertFuelLog(FuelLogData log) => into(fuelLogs).insert(log);

  /// Update fuel log
  Future<bool> updateFuelLog(FuelLogData log) => update(fuelLogs).replace(log);

  /// Delete fuel log
  Future<bool> deleteFuelLog(int id) async {
    final result = await (delete(fuelLogs)..where((f) => f.id.equals(id))).go();
    return result > 0;
  }

  // ============================================================================
  // SERVICE LOG OPERATIONS
  // ============================================================================

  /// Get all service logs for a bike (Reactive Stream)
  Stream<List<ServiceLogData>> watchServiceLogsByBike(int bikeId) =>
      (select(serviceLogs)..where((s) => s.bikeId.equals(bikeId))).watch();

  /// Get service logs ordered by date descending (Reactive Stream)
  Stream<List<ServiceLogData>> watchServiceLogsOrderedByDate(int bikeId) =>
      (select(serviceLogs)
            ..where((s) => s.bikeId.equals(bikeId))
            ..orderBy([
              (s) => OrderingTerm(expression: s.date, mode: OrderingMode.desc),
            ]))
          .watch();

  /// Get the most recent service log
  Future<ServiceLogData?> getLatestServiceLog(int bikeId) =>
      (select(serviceLogs)
            ..where((s) => s.bikeId.equals(bikeId))
            ..orderBy([
              (s) => OrderingTerm(expression: s.date, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();

  /// Insert service log
  Future<int> insertServiceLog(ServiceLogData log) =>
      into(serviceLogs).insert(log);

  /// Update service log
  Future<bool> updateServiceLog(ServiceLogData log) =>
      update(serviceLogs).replace(log);

  /// Delete service log
  Future<bool> deleteServiceLog(int id) async {
    final result = await (delete(
      serviceLogs,
    )..where((s) => s.id.equals(id))).go();
    return result > 0;
  }

  // ============================================================================
  // EXPENSE LOG OPERATIONS
  // ============================================================================

  /// Get all expense logs for a bike (Reactive Stream)
  Stream<List<ExpenseLogData>> watchExpenseLogsByBike(int bikeId) =>
      (select(expenseLogs)..where((e) => e.bikeId.equals(bikeId))).watch();

  /// Get expense logs ordered by date descending (Reactive Stream)
  Stream<List<ExpenseLogData>> watchExpenseLogsOrderedByDate(int bikeId) =>
      (select(expenseLogs)
            ..where((e) => e.bikeId.equals(bikeId))
            ..orderBy([
              (e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc),
            ]))
          .watch();

  /// Insert expense log
  Future<int> insertExpenseLog(ExpenseLogData log) =>
      into(expenseLogs).insert(log);

  /// Update expense log
  Future<bool> updateExpenseLog(ExpenseLogData log) =>
      update(expenseLogs).replace(log);

  /// Delete expense log
  Future<bool> deleteExpenseLog(int id) async {
    final result = await (delete(
      expenseLogs,
    )..where((e) => e.id.equals(id))).go();
    return result > 0;
  }

  // ============================================================================
  // RIDE LOG OPERATIONS
  // ============================================================================

  /// Get all ride logs for a bike (Reactive Stream)
  Stream<List<RideLogData>> watchRideLogsByBike(int bikeId) =>
      (select(rideLogs)..where((r) => r.bikeId.equals(bikeId))).watch();

  /// Get ride logs ordered by start time descending (Reactive Stream)
  Stream<List<RideLogData>> watchRideLogsOrderedByDate(int bikeId) =>
      (select(rideLogs)
            ..where((r) => r.bikeId.equals(bikeId))
            ..orderBy([
              (r) => OrderingTerm(
                expression: r.startTime,
                mode: OrderingMode.desc,
              ),
            ]))
          .watch();

  /// Get a single ride log by ID (Reactive Stream)
  Stream<RideLogData?> watchRideById(int id) =>
      (select(rideLogs)..where((r) => r.id.equals(id))).watchSingleOrNull();

  /// Insert ride log
  Future<int> insertRideLog(RideLogData log) => into(rideLogs).insert(log);

  /// Update ride log
  Future<bool> updateRideLog(RideLogData log) => update(rideLogs).replace(log);

  /// Delete ride log
  Future<bool> deleteRideLog(int id) async {
    final result = await (delete(rideLogs)..where((r) => r.id.equals(id))).go();
    return result > 0;
  }
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/revmate_db.db');

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase(file);
  });
}
