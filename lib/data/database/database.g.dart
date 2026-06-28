// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BikesTable extends Bikes with TableInfo<$BikesTable, BikeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentOdometerMeta = const VerificationMeta(
    'currentOdometer',
  );
  @override
  late final GeneratedColumn<int> currentOdometer = GeneratedColumn<int>(
    'current_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _insuranceExpiryMeta = const VerificationMeta(
    'insuranceExpiry',
  );
  @override
  late final GeneratedColumn<DateTime> insuranceExpiry =
      GeneratedColumn<DateTime>(
        'insurance_expiry',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pucExpiryMeta = const VerificationMeta(
    'pucExpiry',
  );
  @override
  late final GeneratedColumn<DateTime> pucExpiry = GeneratedColumn<DateTime>(
    'puc_expiry',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    make,
    model,
    year,
    currentOdometer,
    insuranceExpiry,
    pucExpiry,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bikes';
  @override
  VerificationContext validateIntegrity(
    Insertable<BikeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('current_odometer')) {
      context.handle(
        _currentOdometerMeta,
        currentOdometer.isAcceptableOrUnknown(
          data['current_odometer']!,
          _currentOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentOdometerMeta);
    }
    if (data.containsKey('insurance_expiry')) {
      context.handle(
        _insuranceExpiryMeta,
        insuranceExpiry.isAcceptableOrUnknown(
          data['insurance_expiry']!,
          _insuranceExpiryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_insuranceExpiryMeta);
    }
    if (data.containsKey('puc_expiry')) {
      context.handle(
        _pucExpiryMeta,
        pucExpiry.isAcceptableOrUnknown(data['puc_expiry']!, _pucExpiryMeta),
      );
    } else if (isInserting) {
      context.missing(_pucExpiryMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BikeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BikeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      currentOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_odometer'],
      )!,
      insuranceExpiry: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}insurance_expiry'],
      )!,
      pucExpiry: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}puc_expiry'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
    );
  }

  @override
  $BikesTable createAlias(String alias) {
    return $BikesTable(attachedDatabase, alias);
  }
}

class BikeData extends DataClass implements Insertable<BikeData> {
  final int id;
  final String name;
  final String make;
  final String model;
  final int year;
  final int currentOdometer;
  final DateTime insuranceExpiry;
  final DateTime pucExpiry;
  final String? photoPath;
  const BikeData({
    required this.id,
    required this.name,
    required this.make,
    required this.model,
    required this.year,
    required this.currentOdometer,
    required this.insuranceExpiry,
    required this.pucExpiry,
    this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['current_odometer'] = Variable<int>(currentOdometer);
    map['insurance_expiry'] = Variable<DateTime>(insuranceExpiry);
    map['puc_expiry'] = Variable<DateTime>(pucExpiry);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    return map;
  }

  BikesCompanion toCompanion(bool nullToAbsent) {
    return BikesCompanion(
      id: Value(id),
      name: Value(name),
      make: Value(make),
      model: Value(model),
      year: Value(year),
      currentOdometer: Value(currentOdometer),
      insuranceExpiry: Value(insuranceExpiry),
      pucExpiry: Value(pucExpiry),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory BikeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BikeData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      currentOdometer: serializer.fromJson<int>(json['currentOdometer']),
      insuranceExpiry: serializer.fromJson<DateTime>(json['insuranceExpiry']),
      pucExpiry: serializer.fromJson<DateTime>(json['pucExpiry']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'currentOdometer': serializer.toJson<int>(currentOdometer),
      'insuranceExpiry': serializer.toJson<DateTime>(insuranceExpiry),
      'pucExpiry': serializer.toJson<DateTime>(pucExpiry),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  BikeData copyWith({
    int? id,
    String? name,
    String? make,
    String? model,
    int? year,
    int? currentOdometer,
    DateTime? insuranceExpiry,
    DateTime? pucExpiry,
    Value<String?> photoPath = const Value.absent(),
  }) => BikeData(
    id: id ?? this.id,
    name: name ?? this.name,
    make: make ?? this.make,
    model: model ?? this.model,
    year: year ?? this.year,
    currentOdometer: currentOdometer ?? this.currentOdometer,
    insuranceExpiry: insuranceExpiry ?? this.insuranceExpiry,
    pucExpiry: pucExpiry ?? this.pucExpiry,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
  );
  BikeData copyWithCompanion(BikesCompanion data) {
    return BikeData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      currentOdometer: data.currentOdometer.present
          ? data.currentOdometer.value
          : this.currentOdometer,
      insuranceExpiry: data.insuranceExpiry.present
          ? data.insuranceExpiry.value
          : this.insuranceExpiry,
      pucExpiry: data.pucExpiry.present ? data.pucExpiry.value : this.pucExpiry,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BikeData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('currentOdometer: $currentOdometer, ')
          ..write('insuranceExpiry: $insuranceExpiry, ')
          ..write('pucExpiry: $pucExpiry, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    make,
    model,
    year,
    currentOdometer,
    insuranceExpiry,
    pucExpiry,
    photoPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BikeData &&
          other.id == this.id &&
          other.name == this.name &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.currentOdometer == this.currentOdometer &&
          other.insuranceExpiry == this.insuranceExpiry &&
          other.pucExpiry == this.pucExpiry &&
          other.photoPath == this.photoPath);
}

class BikesCompanion extends UpdateCompanion<BikeData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> make;
  final Value<String> model;
  final Value<int> year;
  final Value<int> currentOdometer;
  final Value<DateTime> insuranceExpiry;
  final Value<DateTime> pucExpiry;
  final Value<String?> photoPath;
  const BikesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.currentOdometer = const Value.absent(),
    this.insuranceExpiry = const Value.absent(),
    this.pucExpiry = const Value.absent(),
    this.photoPath = const Value.absent(),
  });
  BikesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String make,
    required String model,
    required int year,
    required int currentOdometer,
    required DateTime insuranceExpiry,
    required DateTime pucExpiry,
    this.photoPath = const Value.absent(),
  }) : name = Value(name),
       make = Value(make),
       model = Value(model),
       year = Value(year),
       currentOdometer = Value(currentOdometer),
       insuranceExpiry = Value(insuranceExpiry),
       pucExpiry = Value(pucExpiry);
  static Insertable<BikeData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<int>? currentOdometer,
    Expression<DateTime>? insuranceExpiry,
    Expression<DateTime>? pucExpiry,
    Expression<String>? photoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (currentOdometer != null) 'current_odometer': currentOdometer,
      if (insuranceExpiry != null) 'insurance_expiry': insuranceExpiry,
      if (pucExpiry != null) 'puc_expiry': pucExpiry,
      if (photoPath != null) 'photo_path': photoPath,
    });
  }

  BikesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? make,
    Value<String>? model,
    Value<int>? year,
    Value<int>? currentOdometer,
    Value<DateTime>? insuranceExpiry,
    Value<DateTime>? pucExpiry,
    Value<String?>? photoPath,
  }) {
    return BikesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      currentOdometer: currentOdometer ?? this.currentOdometer,
      insuranceExpiry: insuranceExpiry ?? this.insuranceExpiry,
      pucExpiry: pucExpiry ?? this.pucExpiry,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (currentOdometer.present) {
      map['current_odometer'] = Variable<int>(currentOdometer.value);
    }
    if (insuranceExpiry.present) {
      map['insurance_expiry'] = Variable<DateTime>(insuranceExpiry.value);
    }
    if (pucExpiry.present) {
      map['puc_expiry'] = Variable<DateTime>(pucExpiry.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BikesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('currentOdometer: $currentOdometer, ')
          ..write('insuranceExpiry: $insuranceExpiry, ')
          ..write('pucExpiry: $pucExpiry, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }
}

class $FuelLogsTable extends FuelLogs
    with TableInfo<$FuelLogsTable, FuelLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bikes (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costTotalMeta = const VerificationMeta(
    'costTotal',
  );
  @override
  late final GeneratedColumn<double> costTotal = GeneratedColumn<double>(
    'cost_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPerLiterMeta = const VerificationMeta(
    'costPerLiter',
  );
  @override
  late final GeneratedColumn<double> costPerLiter = GeneratedColumn<double>(
    'cost_per_liter',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullTankMeta = const VerificationMeta(
    'fullTank',
  );
  @override
  late final GeneratedColumn<bool> fullTank = GeneratedColumn<bool>(
    'full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("full_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bikeId,
    date,
    odometer,
    liters,
    costTotal,
    costPerLiter,
    fullTank,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bikeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('cost_total')) {
      context.handle(
        _costTotalMeta,
        costTotal.isAcceptableOrUnknown(data['cost_total']!, _costTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_costTotalMeta);
    }
    if (data.containsKey('cost_per_liter')) {
      context.handle(
        _costPerLiterMeta,
        costPerLiter.isAcceptableOrUnknown(
          data['cost_per_liter']!,
          _costPerLiterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costPerLiterMeta);
    }
    if (data.containsKey('full_tank')) {
      context.handle(
        _fullTankMeta,
        fullTank.isAcceptableOrUnknown(data['full_tank']!, _fullTankMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      )!,
      costTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_total'],
      )!,
      costPerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_per_liter'],
      )!,
      fullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}full_tank'],
      )!,
    );
  }

  @override
  $FuelLogsTable createAlias(String alias) {
    return $FuelLogsTable(attachedDatabase, alias);
  }
}

class FuelLogData extends DataClass implements Insertable<FuelLogData> {
  final int id;
  final int bikeId;
  final DateTime date;
  final int odometer;
  final double liters;
  final double costTotal;
  final double costPerLiter;
  final bool fullTank;
  const FuelLogData({
    required this.id,
    required this.bikeId,
    required this.date,
    required this.odometer,
    required this.liters,
    required this.costTotal,
    required this.costPerLiter,
    required this.fullTank,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bike_id'] = Variable<int>(bikeId);
    map['date'] = Variable<DateTime>(date);
    map['odometer'] = Variable<int>(odometer);
    map['liters'] = Variable<double>(liters);
    map['cost_total'] = Variable<double>(costTotal);
    map['cost_per_liter'] = Variable<double>(costPerLiter);
    map['full_tank'] = Variable<bool>(fullTank);
    return map;
  }

  FuelLogsCompanion toCompanion(bool nullToAbsent) {
    return FuelLogsCompanion(
      id: Value(id),
      bikeId: Value(bikeId),
      date: Value(date),
      odometer: Value(odometer),
      liters: Value(liters),
      costTotal: Value(costTotal),
      costPerLiter: Value(costPerLiter),
      fullTank: Value(fullTank),
    );
  }

  factory FuelLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelLogData(
      id: serializer.fromJson<int>(json['id']),
      bikeId: serializer.fromJson<int>(json['bikeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometer: serializer.fromJson<int>(json['odometer']),
      liters: serializer.fromJson<double>(json['liters']),
      costTotal: serializer.fromJson<double>(json['costTotal']),
      costPerLiter: serializer.fromJson<double>(json['costPerLiter']),
      fullTank: serializer.fromJson<bool>(json['fullTank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bikeId': serializer.toJson<int>(bikeId),
      'date': serializer.toJson<DateTime>(date),
      'odometer': serializer.toJson<int>(odometer),
      'liters': serializer.toJson<double>(liters),
      'costTotal': serializer.toJson<double>(costTotal),
      'costPerLiter': serializer.toJson<double>(costPerLiter),
      'fullTank': serializer.toJson<bool>(fullTank),
    };
  }

  FuelLogData copyWith({
    int? id,
    int? bikeId,
    DateTime? date,
    int? odometer,
    double? liters,
    double? costTotal,
    double? costPerLiter,
    bool? fullTank,
  }) => FuelLogData(
    id: id ?? this.id,
    bikeId: bikeId ?? this.bikeId,
    date: date ?? this.date,
    odometer: odometer ?? this.odometer,
    liters: liters ?? this.liters,
    costTotal: costTotal ?? this.costTotal,
    costPerLiter: costPerLiter ?? this.costPerLiter,
    fullTank: fullTank ?? this.fullTank,
  );
  FuelLogData copyWithCompanion(FuelLogsCompanion data) {
    return FuelLogData(
      id: data.id.present ? data.id.value : this.id,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      date: data.date.present ? data.date.value : this.date,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      liters: data.liters.present ? data.liters.value : this.liters,
      costTotal: data.costTotal.present ? data.costTotal.value : this.costTotal,
      costPerLiter: data.costPerLiter.present
          ? data.costPerLiter.value
          : this.costPerLiter,
      fullTank: data.fullTank.present ? data.fullTank.value : this.fullTank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelLogData(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('liters: $liters, ')
          ..write('costTotal: $costTotal, ')
          ..write('costPerLiter: $costPerLiter, ')
          ..write('fullTank: $fullTank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bikeId,
    date,
    odometer,
    liters,
    costTotal,
    costPerLiter,
    fullTank,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelLogData &&
          other.id == this.id &&
          other.bikeId == this.bikeId &&
          other.date == this.date &&
          other.odometer == this.odometer &&
          other.liters == this.liters &&
          other.costTotal == this.costTotal &&
          other.costPerLiter == this.costPerLiter &&
          other.fullTank == this.fullTank);
}

class FuelLogsCompanion extends UpdateCompanion<FuelLogData> {
  final Value<int> id;
  final Value<int> bikeId;
  final Value<DateTime> date;
  final Value<int> odometer;
  final Value<double> liters;
  final Value<double> costTotal;
  final Value<double> costPerLiter;
  final Value<bool> fullTank;
  const FuelLogsCompanion({
    this.id = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometer = const Value.absent(),
    this.liters = const Value.absent(),
    this.costTotal = const Value.absent(),
    this.costPerLiter = const Value.absent(),
    this.fullTank = const Value.absent(),
  });
  FuelLogsCompanion.insert({
    this.id = const Value.absent(),
    required int bikeId,
    required DateTime date,
    required int odometer,
    required double liters,
    required double costTotal,
    required double costPerLiter,
    this.fullTank = const Value.absent(),
  }) : bikeId = Value(bikeId),
       date = Value(date),
       odometer = Value(odometer),
       liters = Value(liters),
       costTotal = Value(costTotal),
       costPerLiter = Value(costPerLiter);
  static Insertable<FuelLogData> custom({
    Expression<int>? id,
    Expression<int>? bikeId,
    Expression<DateTime>? date,
    Expression<int>? odometer,
    Expression<double>? liters,
    Expression<double>? costTotal,
    Expression<double>? costPerLiter,
    Expression<bool>? fullTank,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bikeId != null) 'bike_id': bikeId,
      if (date != null) 'date': date,
      if (odometer != null) 'odometer': odometer,
      if (liters != null) 'liters': liters,
      if (costTotal != null) 'cost_total': costTotal,
      if (costPerLiter != null) 'cost_per_liter': costPerLiter,
      if (fullTank != null) 'full_tank': fullTank,
    });
  }

  FuelLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? bikeId,
    Value<DateTime>? date,
    Value<int>? odometer,
    Value<double>? liters,
    Value<double>? costTotal,
    Value<double>? costPerLiter,
    Value<bool>? fullTank,
  }) {
    return FuelLogsCompanion(
      id: id ?? this.id,
      bikeId: bikeId ?? this.bikeId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      liters: liters ?? this.liters,
      costTotal: costTotal ?? this.costTotal,
      costPerLiter: costPerLiter ?? this.costPerLiter,
      fullTank: fullTank ?? this.fullTank,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (costTotal.present) {
      map['cost_total'] = Variable<double>(costTotal.value);
    }
    if (costPerLiter.present) {
      map['cost_per_liter'] = Variable<double>(costPerLiter.value);
    }
    if (fullTank.present) {
      map['full_tank'] = Variable<bool>(fullTank.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelLogsCompanion(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('liters: $liters, ')
          ..write('costTotal: $costTotal, ')
          ..write('costPerLiter: $costPerLiter, ')
          ..write('fullTank: $fullTank')
          ..write(')'))
        .toString();
  }
}

class $ServiceLogsTable extends ServiceLogs
    with TableInfo<$ServiceLogsTable, ServiceLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bikes (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueOdometerMeta = const VerificationMeta(
    'nextDueOdometer',
  );
  @override
  late final GeneratedColumn<int> nextDueOdometer = GeneratedColumn<int>(
    'next_due_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bikeId,
    date,
    odometer,
    serviceType,
    description,
    cost,
    nextDueOdometer,
    nextDueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bikeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('next_due_odometer')) {
      context.handle(
        _nextDueOdometerMeta,
        nextDueOdometer.isAcceptableOrUnknown(
          data['next_due_odometer']!,
          _nextDueOdometerMeta,
        ),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      nextDueOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_odometer'],
      ),
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
    );
  }

  @override
  $ServiceLogsTable createAlias(String alias) {
    return $ServiceLogsTable(attachedDatabase, alias);
  }
}

class ServiceLogData extends DataClass implements Insertable<ServiceLogData> {
  final int id;
  final int bikeId;
  final DateTime date;
  final int odometer;
  final String serviceType;
  final String description;
  final double cost;
  final int? nextDueOdometer;
  final DateTime? nextDueDate;
  const ServiceLogData({
    required this.id,
    required this.bikeId,
    required this.date,
    required this.odometer,
    required this.serviceType,
    required this.description,
    required this.cost,
    this.nextDueOdometer,
    this.nextDueDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bike_id'] = Variable<int>(bikeId);
    map['date'] = Variable<DateTime>(date);
    map['odometer'] = Variable<int>(odometer);
    map['service_type'] = Variable<String>(serviceType);
    map['description'] = Variable<String>(description);
    map['cost'] = Variable<double>(cost);
    if (!nullToAbsent || nextDueOdometer != null) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer);
    }
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    return map;
  }

  ServiceLogsCompanion toCompanion(bool nullToAbsent) {
    return ServiceLogsCompanion(
      id: Value(id),
      bikeId: Value(bikeId),
      date: Value(date),
      odometer: Value(odometer),
      serviceType: Value(serviceType),
      description: Value(description),
      cost: Value(cost),
      nextDueOdometer: nextDueOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueOdometer),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
    );
  }

  factory ServiceLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceLogData(
      id: serializer.fromJson<int>(json['id']),
      bikeId: serializer.fromJson<int>(json['bikeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometer: serializer.fromJson<int>(json['odometer']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      description: serializer.fromJson<String>(json['description']),
      cost: serializer.fromJson<double>(json['cost']),
      nextDueOdometer: serializer.fromJson<int?>(json['nextDueOdometer']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bikeId': serializer.toJson<int>(bikeId),
      'date': serializer.toJson<DateTime>(date),
      'odometer': serializer.toJson<int>(odometer),
      'serviceType': serializer.toJson<String>(serviceType),
      'description': serializer.toJson<String>(description),
      'cost': serializer.toJson<double>(cost),
      'nextDueOdometer': serializer.toJson<int?>(nextDueOdometer),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
    };
  }

  ServiceLogData copyWith({
    int? id,
    int? bikeId,
    DateTime? date,
    int? odometer,
    String? serviceType,
    String? description,
    double? cost,
    Value<int?> nextDueOdometer = const Value.absent(),
    Value<DateTime?> nextDueDate = const Value.absent(),
  }) => ServiceLogData(
    id: id ?? this.id,
    bikeId: bikeId ?? this.bikeId,
    date: date ?? this.date,
    odometer: odometer ?? this.odometer,
    serviceType: serviceType ?? this.serviceType,
    description: description ?? this.description,
    cost: cost ?? this.cost,
    nextDueOdometer: nextDueOdometer.present
        ? nextDueOdometer.value
        : this.nextDueOdometer,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
  );
  ServiceLogData copyWithCompanion(ServiceLogsCompanion data) {
    return ServiceLogData(
      id: data.id.present ? data.id.value : this.id,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      date: data.date.present ? data.date.value : this.date,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      description: data.description.present
          ? data.description.value
          : this.description,
      cost: data.cost.present ? data.cost.value : this.cost,
      nextDueOdometer: data.nextDueOdometer.present
          ? data.nextDueOdometer.value
          : this.nextDueOdometer,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceLogData(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('serviceType: $serviceType, ')
          ..write('description: $description, ')
          ..write('cost: $cost, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('nextDueDate: $nextDueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bikeId,
    date,
    odometer,
    serviceType,
    description,
    cost,
    nextDueOdometer,
    nextDueDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceLogData &&
          other.id == this.id &&
          other.bikeId == this.bikeId &&
          other.date == this.date &&
          other.odometer == this.odometer &&
          other.serviceType == this.serviceType &&
          other.description == this.description &&
          other.cost == this.cost &&
          other.nextDueOdometer == this.nextDueOdometer &&
          other.nextDueDate == this.nextDueDate);
}

class ServiceLogsCompanion extends UpdateCompanion<ServiceLogData> {
  final Value<int> id;
  final Value<int> bikeId;
  final Value<DateTime> date;
  final Value<int> odometer;
  final Value<String> serviceType;
  final Value<String> description;
  final Value<double> cost;
  final Value<int?> nextDueOdometer;
  final Value<DateTime?> nextDueDate;
  const ServiceLogsCompanion({
    this.id = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometer = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.description = const Value.absent(),
    this.cost = const Value.absent(),
    this.nextDueOdometer = const Value.absent(),
    this.nextDueDate = const Value.absent(),
  });
  ServiceLogsCompanion.insert({
    this.id = const Value.absent(),
    required int bikeId,
    required DateTime date,
    required int odometer,
    required String serviceType,
    required String description,
    required double cost,
    this.nextDueOdometer = const Value.absent(),
    this.nextDueDate = const Value.absent(),
  }) : bikeId = Value(bikeId),
       date = Value(date),
       odometer = Value(odometer),
       serviceType = Value(serviceType),
       description = Value(description),
       cost = Value(cost);
  static Insertable<ServiceLogData> custom({
    Expression<int>? id,
    Expression<int>? bikeId,
    Expression<DateTime>? date,
    Expression<int>? odometer,
    Expression<String>? serviceType,
    Expression<String>? description,
    Expression<double>? cost,
    Expression<int>? nextDueOdometer,
    Expression<DateTime>? nextDueDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bikeId != null) 'bike_id': bikeId,
      if (date != null) 'date': date,
      if (odometer != null) 'odometer': odometer,
      if (serviceType != null) 'service_type': serviceType,
      if (description != null) 'description': description,
      if (cost != null) 'cost': cost,
      if (nextDueOdometer != null) 'next_due_odometer': nextDueOdometer,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
    });
  }

  ServiceLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? bikeId,
    Value<DateTime>? date,
    Value<int>? odometer,
    Value<String>? serviceType,
    Value<String>? description,
    Value<double>? cost,
    Value<int?>? nextDueOdometer,
    Value<DateTime?>? nextDueDate,
  }) {
    return ServiceLogsCompanion(
      id: id ?? this.id,
      bikeId: bikeId ?? this.bikeId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      nextDueOdometer: nextDueOdometer ?? this.nextDueOdometer,
      nextDueDate: nextDueDate ?? this.nextDueDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (nextDueOdometer.present) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceLogsCompanion(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('serviceType: $serviceType, ')
          ..write('description: $description, ')
          ..write('cost: $cost, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('nextDueDate: $nextDueDate')
          ..write(')'))
        .toString();
  }
}

class $ExpenseLogsTable extends ExpenseLogs
    with TableInfo<$ExpenseLogsTable, ExpenseLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bikes (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ExpenseCategory>($ExpenseLogsTable.$convertercategory);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bikeId,
    date,
    category,
    description,
    cost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bikeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: $ExpenseLogsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
    );
  }

  @override
  $ExpenseLogsTable createAlias(String alias) {
    return $ExpenseLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseCategory, String, String>
  $convertercategory = const EnumNameConverter<ExpenseCategory>(
    ExpenseCategory.values,
  );
}

class ExpenseLogData extends DataClass implements Insertable<ExpenseLogData> {
  final int id;
  final int bikeId;
  final DateTime date;
  final ExpenseCategory category;
  final String description;
  final double cost;
  const ExpenseLogData({
    required this.id,
    required this.bikeId,
    required this.date,
    required this.category,
    required this.description,
    required this.cost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bike_id'] = Variable<int>(bikeId);
    map['date'] = Variable<DateTime>(date);
    {
      map['category'] = Variable<String>(
        $ExpenseLogsTable.$convertercategory.toSql(category),
      );
    }
    map['description'] = Variable<String>(description);
    map['cost'] = Variable<double>(cost);
    return map;
  }

  ExpenseLogsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseLogsCompanion(
      id: Value(id),
      bikeId: Value(bikeId),
      date: Value(date),
      category: Value(category),
      description: Value(description),
      cost: Value(cost),
    );
  }

  factory ExpenseLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseLogData(
      id: serializer.fromJson<int>(json['id']),
      bikeId: serializer.fromJson<int>(json['bikeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: $ExpenseLogsTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      description: serializer.fromJson<String>(json['description']),
      cost: serializer.fromJson<double>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bikeId': serializer.toJson<int>(bikeId),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(
        $ExpenseLogsTable.$convertercategory.toJson(category),
      ),
      'description': serializer.toJson<String>(description),
      'cost': serializer.toJson<double>(cost),
    };
  }

  ExpenseLogData copyWith({
    int? id,
    int? bikeId,
    DateTime? date,
    ExpenseCategory? category,
    String? description,
    double? cost,
  }) => ExpenseLogData(
    id: id ?? this.id,
    bikeId: bikeId ?? this.bikeId,
    date: date ?? this.date,
    category: category ?? this.category,
    description: description ?? this.description,
    cost: cost ?? this.cost,
  );
  ExpenseLogData copyWithCompanion(ExpenseLogsCompanion data) {
    return ExpenseLogData(
      id: data.id.present ? data.id.value : this.id,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      cost: data.cost.present ? data.cost.value : this.cost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseLogData(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bikeId, date, category, description, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseLogData &&
          other.id == this.id &&
          other.bikeId == this.bikeId &&
          other.date == this.date &&
          other.category == this.category &&
          other.description == this.description &&
          other.cost == this.cost);
}

class ExpenseLogsCompanion extends UpdateCompanion<ExpenseLogData> {
  final Value<int> id;
  final Value<int> bikeId;
  final Value<DateTime> date;
  final Value<ExpenseCategory> category;
  final Value<String> description;
  final Value<double> cost;
  const ExpenseLogsCompanion({
    this.id = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.cost = const Value.absent(),
  });
  ExpenseLogsCompanion.insert({
    this.id = const Value.absent(),
    required int bikeId,
    required DateTime date,
    required ExpenseCategory category,
    required String description,
    required double cost,
  }) : bikeId = Value(bikeId),
       date = Value(date),
       category = Value(category),
       description = Value(description),
       cost = Value(cost);
  static Insertable<ExpenseLogData> custom({
    Expression<int>? id,
    Expression<int>? bikeId,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<String>? description,
    Expression<double>? cost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bikeId != null) 'bike_id': bikeId,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (cost != null) 'cost': cost,
    });
  }

  ExpenseLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? bikeId,
    Value<DateTime>? date,
    Value<ExpenseCategory>? category,
    Value<String>? description,
    Value<double>? cost,
  }) {
    return ExpenseLogsCompanion(
      id: id ?? this.id,
      bikeId: bikeId ?? this.bikeId,
      date: date ?? this.date,
      category: category ?? this.category,
      description: description ?? this.description,
      cost: cost ?? this.cost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ExpenseLogsTable.$convertercategory.toSql(category.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseLogsCompanion(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }
}

class $RideLogsTable extends RideLogs
    with TableInfo<$RideLogsTable, RideLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RideLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bikes (id)',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routePointsMeta = const VerificationMeta(
    'routePoints',
  );
  @override
  late final GeneratedColumn<String> routePoints = GeneratedColumn<String>(
    'route_points',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startOdometerMeta = const VerificationMeta(
    'startOdometer',
  );
  @override
  late final GeneratedColumn<int> startOdometer = GeneratedColumn<int>(
    'start_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endOdometerMeta = const VerificationMeta(
    'endOdometer',
  );
  @override
  late final GeneratedColumn<int> endOdometer = GeneratedColumn<int>(
    'end_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bikeId,
    startTime,
    endTime,
    distanceKm,
    routePoints,
    startOdometer,
    endOdometer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ride_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RideLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bikeIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceKmMeta);
    }
    if (data.containsKey('route_points')) {
      context.handle(
        _routePointsMeta,
        routePoints.isAcceptableOrUnknown(
          data['route_points']!,
          _routePointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_routePointsMeta);
    }
    if (data.containsKey('start_odometer')) {
      context.handle(
        _startOdometerMeta,
        startOdometer.isAcceptableOrUnknown(
          data['start_odometer']!,
          _startOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOdometerMeta);
    }
    if (data.containsKey('end_odometer')) {
      context.handle(
        _endOdometerMeta,
        endOdometer.isAcceptableOrUnknown(
          data['end_odometer']!,
          _endOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endOdometerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RideLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RideLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      )!,
      routePoints: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_points'],
      )!,
      startOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_odometer'],
      )!,
      endOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_odometer'],
      )!,
    );
  }

  @override
  $RideLogsTable createAlias(String alias) {
    return $RideLogsTable(attachedDatabase, alias);
  }
}

class RideLogData extends DataClass implements Insertable<RideLogData> {
  final int id;
  final int bikeId;
  final DateTime startTime;
  final DateTime endTime;
  final double distanceKm;
  final String routePoints;
  final int startOdometer;
  final int endOdometer;
  const RideLogData({
    required this.id,
    required this.bikeId,
    required this.startTime,
    required this.endTime,
    required this.distanceKm,
    required this.routePoints,
    required this.startOdometer,
    required this.endOdometer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bike_id'] = Variable<int>(bikeId);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['distance_km'] = Variable<double>(distanceKm);
    map['route_points'] = Variable<String>(routePoints);
    map['start_odometer'] = Variable<int>(startOdometer);
    map['end_odometer'] = Variable<int>(endOdometer);
    return map;
  }

  RideLogsCompanion toCompanion(bool nullToAbsent) {
    return RideLogsCompanion(
      id: Value(id),
      bikeId: Value(bikeId),
      startTime: Value(startTime),
      endTime: Value(endTime),
      distanceKm: Value(distanceKm),
      routePoints: Value(routePoints),
      startOdometer: Value(startOdometer),
      endOdometer: Value(endOdometer),
    );
  }

  factory RideLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RideLogData(
      id: serializer.fromJson<int>(json['id']),
      bikeId: serializer.fromJson<int>(json['bikeId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      distanceKm: serializer.fromJson<double>(json['distanceKm']),
      routePoints: serializer.fromJson<String>(json['routePoints']),
      startOdometer: serializer.fromJson<int>(json['startOdometer']),
      endOdometer: serializer.fromJson<int>(json['endOdometer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bikeId': serializer.toJson<int>(bikeId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'distanceKm': serializer.toJson<double>(distanceKm),
      'routePoints': serializer.toJson<String>(routePoints),
      'startOdometer': serializer.toJson<int>(startOdometer),
      'endOdometer': serializer.toJson<int>(endOdometer),
    };
  }

  RideLogData copyWith({
    int? id,
    int? bikeId,
    DateTime? startTime,
    DateTime? endTime,
    double? distanceKm,
    String? routePoints,
    int? startOdometer,
    int? endOdometer,
  }) => RideLogData(
    id: id ?? this.id,
    bikeId: bikeId ?? this.bikeId,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    distanceKm: distanceKm ?? this.distanceKm,
    routePoints: routePoints ?? this.routePoints,
    startOdometer: startOdometer ?? this.startOdometer,
    endOdometer: endOdometer ?? this.endOdometer,
  );
  RideLogData copyWithCompanion(RideLogsCompanion data) {
    return RideLogData(
      id: data.id.present ? data.id.value : this.id,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      routePoints: data.routePoints.present
          ? data.routePoints.value
          : this.routePoints,
      startOdometer: data.startOdometer.present
          ? data.startOdometer.value
          : this.startOdometer,
      endOdometer: data.endOdometer.present
          ? data.endOdometer.value
          : this.endOdometer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RideLogData(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('routePoints: $routePoints, ')
          ..write('startOdometer: $startOdometer, ')
          ..write('endOdometer: $endOdometer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bikeId,
    startTime,
    endTime,
    distanceKm,
    routePoints,
    startOdometer,
    endOdometer,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RideLogData &&
          other.id == this.id &&
          other.bikeId == this.bikeId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.distanceKm == this.distanceKm &&
          other.routePoints == this.routePoints &&
          other.startOdometer == this.startOdometer &&
          other.endOdometer == this.endOdometer);
}

class RideLogsCompanion extends UpdateCompanion<RideLogData> {
  final Value<int> id;
  final Value<int> bikeId;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<double> distanceKm;
  final Value<String> routePoints;
  final Value<int> startOdometer;
  final Value<int> endOdometer;
  const RideLogsCompanion({
    this.id = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.routePoints = const Value.absent(),
    this.startOdometer = const Value.absent(),
    this.endOdometer = const Value.absent(),
  });
  RideLogsCompanion.insert({
    this.id = const Value.absent(),
    required int bikeId,
    required DateTime startTime,
    required DateTime endTime,
    required double distanceKm,
    required String routePoints,
    required int startOdometer,
    required int endOdometer,
  }) : bikeId = Value(bikeId),
       startTime = Value(startTime),
       endTime = Value(endTime),
       distanceKm = Value(distanceKm),
       routePoints = Value(routePoints),
       startOdometer = Value(startOdometer),
       endOdometer = Value(endOdometer);
  static Insertable<RideLogData> custom({
    Expression<int>? id,
    Expression<int>? bikeId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<double>? distanceKm,
    Expression<String>? routePoints,
    Expression<int>? startOdometer,
    Expression<int>? endOdometer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bikeId != null) 'bike_id': bikeId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (routePoints != null) 'route_points': routePoints,
      if (startOdometer != null) 'start_odometer': startOdometer,
      if (endOdometer != null) 'end_odometer': endOdometer,
    });
  }

  RideLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? bikeId,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<double>? distanceKm,
    Value<String>? routePoints,
    Value<int>? startOdometer,
    Value<int>? endOdometer,
  }) {
    return RideLogsCompanion(
      id: id ?? this.id,
      bikeId: bikeId ?? this.bikeId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distanceKm: distanceKm ?? this.distanceKm,
      routePoints: routePoints ?? this.routePoints,
      startOdometer: startOdometer ?? this.startOdometer,
      endOdometer: endOdometer ?? this.endOdometer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (routePoints.present) {
      map['route_points'] = Variable<String>(routePoints.value);
    }
    if (startOdometer.present) {
      map['start_odometer'] = Variable<int>(startOdometer.value);
    }
    if (endOdometer.present) {
      map['end_odometer'] = Variable<int>(endOdometer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RideLogsCompanion(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('routePoints: $routePoints, ')
          ..write('startOdometer: $startOdometer, ')
          ..write('endOdometer: $endOdometer')
          ..write(')'))
        .toString();
  }
}

abstract class _$RevMateDatabase extends GeneratedDatabase {
  _$RevMateDatabase(QueryExecutor e) : super(e);
  $RevMateDatabaseManager get managers => $RevMateDatabaseManager(this);
  late final $BikesTable bikes = $BikesTable(this);
  late final $FuelLogsTable fuelLogs = $FuelLogsTable(this);
  late final $ServiceLogsTable serviceLogs = $ServiceLogsTable(this);
  late final $ExpenseLogsTable expenseLogs = $ExpenseLogsTable(this);
  late final $RideLogsTable rideLogs = $RideLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bikes,
    fuelLogs,
    serviceLogs,
    expenseLogs,
    rideLogs,
  ];
}

typedef $$BikesTableCreateCompanionBuilder =
    BikesCompanion Function({
      Value<int> id,
      required String name,
      required String make,
      required String model,
      required int year,
      required int currentOdometer,
      required DateTime insuranceExpiry,
      required DateTime pucExpiry,
      Value<String?> photoPath,
    });
typedef $$BikesTableUpdateCompanionBuilder =
    BikesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> make,
      Value<String> model,
      Value<int> year,
      Value<int> currentOdometer,
      Value<DateTime> insuranceExpiry,
      Value<DateTime> pucExpiry,
      Value<String?> photoPath,
    });

final class $$BikesTableReferences
    extends BaseReferences<_$RevMateDatabase, $BikesTable, BikeData> {
  $$BikesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FuelLogsTable, List<FuelLogData>>
  _fuelLogsRefsTable(_$RevMateDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelLogs,
    aliasName: $_aliasNameGenerator(db.bikes.id, db.fuelLogs.bikeId),
  );

  $$FuelLogsTableProcessedTableManager get fuelLogsRefs {
    final manager = $$FuelLogsTableTableManager(
      $_db,
      $_db.fuelLogs,
    ).filter((f) => f.bikeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServiceLogsTable, List<ServiceLogData>>
  _serviceLogsRefsTable(_$RevMateDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceLogs,
    aliasName: $_aliasNameGenerator(db.bikes.id, db.serviceLogs.bikeId),
  );

  $$ServiceLogsTableProcessedTableManager get serviceLogsRefs {
    final manager = $$ServiceLogsTableTableManager(
      $_db,
      $_db.serviceLogs,
    ).filter((f) => f.bikeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpenseLogsTable, List<ExpenseLogData>>
  _expenseLogsRefsTable(_$RevMateDatabase db) => MultiTypedResultKey.fromTable(
    db.expenseLogs,
    aliasName: $_aliasNameGenerator(db.bikes.id, db.expenseLogs.bikeId),
  );

  $$ExpenseLogsTableProcessedTableManager get expenseLogsRefs {
    final manager = $$ExpenseLogsTableTableManager(
      $_db,
      $_db.expenseLogs,
    ).filter((f) => f.bikeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expenseLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RideLogsTable, List<RideLogData>>
  _rideLogsRefsTable(_$RevMateDatabase db) => MultiTypedResultKey.fromTable(
    db.rideLogs,
    aliasName: $_aliasNameGenerator(db.bikes.id, db.rideLogs.bikeId),
  );

  $$RideLogsTableProcessedTableManager get rideLogsRefs {
    final manager = $$RideLogsTableTableManager(
      $_db,
      $_db.rideLogs,
    ).filter((f) => f.bikeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rideLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BikesTableFilterComposer
    extends Composer<_$RevMateDatabase, $BikesTable> {
  $$BikesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get insuranceExpiry => $composableBuilder(
    column: $table.insuranceExpiry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get pucExpiry => $composableBuilder(
    column: $table.pucExpiry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> fuelLogsRefs(
    Expression<bool> Function($$FuelLogsTableFilterComposer f) f,
  ) {
    final $$FuelLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelLogsTableFilterComposer(
            $db: $db,
            $table: $db.fuelLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> serviceLogsRefs(
    Expression<bool> Function($$ServiceLogsTableFilterComposer f) f,
  ) {
    final $$ServiceLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceLogsTableFilterComposer(
            $db: $db,
            $table: $db.serviceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expenseLogsRefs(
    Expression<bool> Function($$ExpenseLogsTableFilterComposer f) f,
  ) {
    final $$ExpenseLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseLogsTableFilterComposer(
            $db: $db,
            $table: $db.expenseLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rideLogsRefs(
    Expression<bool> Function($$RideLogsTableFilterComposer f) f,
  ) {
    final $$RideLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rideLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideLogsTableFilterComposer(
            $db: $db,
            $table: $db.rideLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BikesTableOrderingComposer
    extends Composer<_$RevMateDatabase, $BikesTable> {
  $$BikesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get insuranceExpiry => $composableBuilder(
    column: $table.insuranceExpiry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get pucExpiry => $composableBuilder(
    column: $table.pucExpiry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BikesTableAnnotationComposer
    extends Composer<_$RevMateDatabase, $BikesTable> {
  $$BikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get insuranceExpiry => $composableBuilder(
    column: $table.insuranceExpiry,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get pucExpiry =>
      $composableBuilder(column: $table.pucExpiry, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  Expression<T> fuelLogsRefs<T extends Object>(
    Expression<T> Function($$FuelLogsTableAnnotationComposer a) f,
  ) {
    final $$FuelLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> serviceLogsRefs<T extends Object>(
    Expression<T> Function($$ServiceLogsTableAnnotationComposer a) f,
  ) {
    final $$ServiceLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expenseLogsRefs<T extends Object>(
    Expression<T> Function($$ExpenseLogsTableAnnotationComposer a) f,
  ) {
    final $$ExpenseLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.expenseLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> rideLogsRefs<T extends Object>(
    Expression<T> Function($$RideLogsTableAnnotationComposer a) f,
  ) {
    final $$RideLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rideLogs,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.rideLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BikesTableTableManager
    extends
        RootTableManager<
          _$RevMateDatabase,
          $BikesTable,
          BikeData,
          $$BikesTableFilterComposer,
          $$BikesTableOrderingComposer,
          $$BikesTableAnnotationComposer,
          $$BikesTableCreateCompanionBuilder,
          $$BikesTableUpdateCompanionBuilder,
          (BikeData, $$BikesTableReferences),
          BikeData,
          PrefetchHooks Function({
            bool fuelLogsRefs,
            bool serviceLogsRefs,
            bool expenseLogsRefs,
            bool rideLogsRefs,
          })
        > {
  $$BikesTableTableManager(_$RevMateDatabase db, $BikesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BikesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> currentOdometer = const Value.absent(),
                Value<DateTime> insuranceExpiry = const Value.absent(),
                Value<DateTime> pucExpiry = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => BikesCompanion(
                id: id,
                name: name,
                make: make,
                model: model,
                year: year,
                currentOdometer: currentOdometer,
                insuranceExpiry: insuranceExpiry,
                pucExpiry: pucExpiry,
                photoPath: photoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String make,
                required String model,
                required int year,
                required int currentOdometer,
                required DateTime insuranceExpiry,
                required DateTime pucExpiry,
                Value<String?> photoPath = const Value.absent(),
              }) => BikesCompanion.insert(
                id: id,
                name: name,
                make: make,
                model: model,
                year: year,
                currentOdometer: currentOdometer,
                insuranceExpiry: insuranceExpiry,
                pucExpiry: pucExpiry,
                photoPath: photoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BikesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fuelLogsRefs = false,
                serviceLogsRefs = false,
                expenseLogsRefs = false,
                rideLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fuelLogsRefs) db.fuelLogs,
                    if (serviceLogsRefs) db.serviceLogs,
                    if (expenseLogsRefs) db.expenseLogs,
                    if (rideLogsRefs) db.rideLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fuelLogsRefs)
                        await $_getPrefetchedData<
                          BikeData,
                          $BikesTable,
                          FuelLogData
                        >(
                          currentTable: table,
                          referencedTable: $$BikesTableReferences
                              ._fuelLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BikesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bikeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (serviceLogsRefs)
                        await $_getPrefetchedData<
                          BikeData,
                          $BikesTable,
                          ServiceLogData
                        >(
                          currentTable: table,
                          referencedTable: $$BikesTableReferences
                              ._serviceLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BikesTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bikeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expenseLogsRefs)
                        await $_getPrefetchedData<
                          BikeData,
                          $BikesTable,
                          ExpenseLogData
                        >(
                          currentTable: table,
                          referencedTable: $$BikesTableReferences
                              ._expenseLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BikesTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bikeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (rideLogsRefs)
                        await $_getPrefetchedData<
                          BikeData,
                          $BikesTable,
                          RideLogData
                        >(
                          currentTable: table,
                          referencedTable: $$BikesTableReferences
                              ._rideLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BikesTableReferences(
                                db,
                                table,
                                p0,
                              ).rideLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bikeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BikesTableProcessedTableManager =
    ProcessedTableManager<
      _$RevMateDatabase,
      $BikesTable,
      BikeData,
      $$BikesTableFilterComposer,
      $$BikesTableOrderingComposer,
      $$BikesTableAnnotationComposer,
      $$BikesTableCreateCompanionBuilder,
      $$BikesTableUpdateCompanionBuilder,
      (BikeData, $$BikesTableReferences),
      BikeData,
      PrefetchHooks Function({
        bool fuelLogsRefs,
        bool serviceLogsRefs,
        bool expenseLogsRefs,
        bool rideLogsRefs,
      })
    >;
typedef $$FuelLogsTableCreateCompanionBuilder =
    FuelLogsCompanion Function({
      Value<int> id,
      required int bikeId,
      required DateTime date,
      required int odometer,
      required double liters,
      required double costTotal,
      required double costPerLiter,
      Value<bool> fullTank,
    });
typedef $$FuelLogsTableUpdateCompanionBuilder =
    FuelLogsCompanion Function({
      Value<int> id,
      Value<int> bikeId,
      Value<DateTime> date,
      Value<int> odometer,
      Value<double> liters,
      Value<double> costTotal,
      Value<double> costPerLiter,
      Value<bool> fullTank,
    });

final class $$FuelLogsTableReferences
    extends BaseReferences<_$RevMateDatabase, $FuelLogsTable, FuelLogData> {
  $$FuelLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BikesTable _bikeIdTable(_$RevMateDatabase db) => db.bikes.createAlias(
    $_aliasNameGenerator(db.fuelLogs.bikeId, db.bikes.id),
  );

  $$BikesTableProcessedTableManager get bikeId {
    final $_column = $_itemColumn<int>('bike_id')!;

    final manager = $$BikesTableTableManager(
      $_db,
      $_db.bikes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bikeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelLogsTableFilterComposer
    extends Composer<_$RevMateDatabase, $FuelLogsTable> {
  $$FuelLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costTotal => $composableBuilder(
    column: $table.costTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPerLiter => $composableBuilder(
    column: $table.costPerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fullTank => $composableBuilder(
    column: $table.fullTank,
    builder: (column) => ColumnFilters(column),
  );

  $$BikesTableFilterComposer get bikeId {
    final $$BikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableFilterComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelLogsTableOrderingComposer
    extends Composer<_$RevMateDatabase, $FuelLogsTable> {
  $$FuelLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costTotal => $composableBuilder(
    column: $table.costTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPerLiter => $composableBuilder(
    column: $table.costPerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fullTank => $composableBuilder(
    column: $table.fullTank,
    builder: (column) => ColumnOrderings(column),
  );

  $$BikesTableOrderingComposer get bikeId {
    final $$BikesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableOrderingComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelLogsTableAnnotationComposer
    extends Composer<_$RevMateDatabase, $FuelLogsTable> {
  $$FuelLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<double> get costTotal =>
      $composableBuilder(column: $table.costTotal, builder: (column) => column);

  GeneratedColumn<double> get costPerLiter => $composableBuilder(
    column: $table.costPerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get fullTank =>
      $composableBuilder(column: $table.fullTank, builder: (column) => column);

  $$BikesTableAnnotationComposer get bikeId {
    final $$BikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableAnnotationComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelLogsTableTableManager
    extends
        RootTableManager<
          _$RevMateDatabase,
          $FuelLogsTable,
          FuelLogData,
          $$FuelLogsTableFilterComposer,
          $$FuelLogsTableOrderingComposer,
          $$FuelLogsTableAnnotationComposer,
          $$FuelLogsTableCreateCompanionBuilder,
          $$FuelLogsTableUpdateCompanionBuilder,
          (FuelLogData, $$FuelLogsTableReferences),
          FuelLogData,
          PrefetchHooks Function({bool bikeId})
        > {
  $$FuelLogsTableTableManager(_$RevMateDatabase db, $FuelLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bikeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<double> costTotal = const Value.absent(),
                Value<double> costPerLiter = const Value.absent(),
                Value<bool> fullTank = const Value.absent(),
              }) => FuelLogsCompanion(
                id: id,
                bikeId: bikeId,
                date: date,
                odometer: odometer,
                liters: liters,
                costTotal: costTotal,
                costPerLiter: costPerLiter,
                fullTank: fullTank,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bikeId,
                required DateTime date,
                required int odometer,
                required double liters,
                required double costTotal,
                required double costPerLiter,
                Value<bool> fullTank = const Value.absent(),
              }) => FuelLogsCompanion.insert(
                id: id,
                bikeId: bikeId,
                date: date,
                odometer: odometer,
                liters: liters,
                costTotal: costTotal,
                costPerLiter: costPerLiter,
                fullTank: fullTank,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FuelLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bikeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bikeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bikeId,
                                referencedTable: $$FuelLogsTableReferences
                                    ._bikeIdTable(db),
                                referencedColumn: $$FuelLogsTableReferences
                                    ._bikeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$RevMateDatabase,
      $FuelLogsTable,
      FuelLogData,
      $$FuelLogsTableFilterComposer,
      $$FuelLogsTableOrderingComposer,
      $$FuelLogsTableAnnotationComposer,
      $$FuelLogsTableCreateCompanionBuilder,
      $$FuelLogsTableUpdateCompanionBuilder,
      (FuelLogData, $$FuelLogsTableReferences),
      FuelLogData,
      PrefetchHooks Function({bool bikeId})
    >;
typedef $$ServiceLogsTableCreateCompanionBuilder =
    ServiceLogsCompanion Function({
      Value<int> id,
      required int bikeId,
      required DateTime date,
      required int odometer,
      required String serviceType,
      required String description,
      required double cost,
      Value<int?> nextDueOdometer,
      Value<DateTime?> nextDueDate,
    });
typedef $$ServiceLogsTableUpdateCompanionBuilder =
    ServiceLogsCompanion Function({
      Value<int> id,
      Value<int> bikeId,
      Value<DateTime> date,
      Value<int> odometer,
      Value<String> serviceType,
      Value<String> description,
      Value<double> cost,
      Value<int?> nextDueOdometer,
      Value<DateTime?> nextDueDate,
    });

final class $$ServiceLogsTableReferences
    extends
        BaseReferences<_$RevMateDatabase, $ServiceLogsTable, ServiceLogData> {
  $$ServiceLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BikesTable _bikeIdTable(_$RevMateDatabase db) => db.bikes.createAlias(
    $_aliasNameGenerator(db.serviceLogs.bikeId, db.bikes.id),
  );

  $$BikesTableProcessedTableManager get bikeId {
    final $_column = $_itemColumn<int>('bike_id')!;

    final manager = $$BikesTableTableManager(
      $_db,
      $_db.bikes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bikeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServiceLogsTableFilterComposer
    extends Composer<_$RevMateDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  $$BikesTableFilterComposer get bikeId {
    final $$BikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableFilterComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableOrderingComposer
    extends Composer<_$RevMateDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$BikesTableOrderingComposer get bikeId {
    final $$BikesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableOrderingComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableAnnotationComposer
    extends Composer<_$RevMateDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  $$BikesTableAnnotationComposer get bikeId {
    final $$BikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableAnnotationComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableTableManager
    extends
        RootTableManager<
          _$RevMateDatabase,
          $ServiceLogsTable,
          ServiceLogData,
          $$ServiceLogsTableFilterComposer,
          $$ServiceLogsTableOrderingComposer,
          $$ServiceLogsTableAnnotationComposer,
          $$ServiceLogsTableCreateCompanionBuilder,
          $$ServiceLogsTableUpdateCompanionBuilder,
          (ServiceLogData, $$ServiceLogsTableReferences),
          ServiceLogData,
          PrefetchHooks Function({bool bikeId})
        > {
  $$ServiceLogsTableTableManager(_$RevMateDatabase db, $ServiceLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bikeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
              }) => ServiceLogsCompanion(
                id: id,
                bikeId: bikeId,
                date: date,
                odometer: odometer,
                serviceType: serviceType,
                description: description,
                cost: cost,
                nextDueOdometer: nextDueOdometer,
                nextDueDate: nextDueDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bikeId,
                required DateTime date,
                required int odometer,
                required String serviceType,
                required String description,
                required double cost,
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
              }) => ServiceLogsCompanion.insert(
                id: id,
                bikeId: bikeId,
                date: date,
                odometer: odometer,
                serviceType: serviceType,
                description: description,
                cost: cost,
                nextDueOdometer: nextDueOdometer,
                nextDueDate: nextDueDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ServiceLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bikeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bikeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bikeId,
                                referencedTable: $$ServiceLogsTableReferences
                                    ._bikeIdTable(db),
                                referencedColumn: $$ServiceLogsTableReferences
                                    ._bikeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ServiceLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$RevMateDatabase,
      $ServiceLogsTable,
      ServiceLogData,
      $$ServiceLogsTableFilterComposer,
      $$ServiceLogsTableOrderingComposer,
      $$ServiceLogsTableAnnotationComposer,
      $$ServiceLogsTableCreateCompanionBuilder,
      $$ServiceLogsTableUpdateCompanionBuilder,
      (ServiceLogData, $$ServiceLogsTableReferences),
      ServiceLogData,
      PrefetchHooks Function({bool bikeId})
    >;
typedef $$ExpenseLogsTableCreateCompanionBuilder =
    ExpenseLogsCompanion Function({
      Value<int> id,
      required int bikeId,
      required DateTime date,
      required ExpenseCategory category,
      required String description,
      required double cost,
    });
typedef $$ExpenseLogsTableUpdateCompanionBuilder =
    ExpenseLogsCompanion Function({
      Value<int> id,
      Value<int> bikeId,
      Value<DateTime> date,
      Value<ExpenseCategory> category,
      Value<String> description,
      Value<double> cost,
    });

final class $$ExpenseLogsTableReferences
    extends
        BaseReferences<_$RevMateDatabase, $ExpenseLogsTable, ExpenseLogData> {
  $$ExpenseLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BikesTable _bikeIdTable(_$RevMateDatabase db) => db.bikes.createAlias(
    $_aliasNameGenerator(db.expenseLogs.bikeId, db.bikes.id),
  );

  $$BikesTableProcessedTableManager get bikeId {
    final $_column = $_itemColumn<int>('bike_id')!;

    final manager = $$BikesTableTableManager(
      $_db,
      $_db.bikes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bikeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpenseLogsTableFilterComposer
    extends Composer<_$RevMateDatabase, $ExpenseLogsTable> {
  $$ExpenseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  $$BikesTableFilterComposer get bikeId {
    final $$BikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableFilterComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseLogsTableOrderingComposer
    extends Composer<_$RevMateDatabase, $ExpenseLogsTable> {
  $$ExpenseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  $$BikesTableOrderingComposer get bikeId {
    final $$BikesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableOrderingComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseLogsTableAnnotationComposer
    extends Composer<_$RevMateDatabase, $ExpenseLogsTable> {
  $$ExpenseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  $$BikesTableAnnotationComposer get bikeId {
    final $$BikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableAnnotationComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseLogsTableTableManager
    extends
        RootTableManager<
          _$RevMateDatabase,
          $ExpenseLogsTable,
          ExpenseLogData,
          $$ExpenseLogsTableFilterComposer,
          $$ExpenseLogsTableOrderingComposer,
          $$ExpenseLogsTableAnnotationComposer,
          $$ExpenseLogsTableCreateCompanionBuilder,
          $$ExpenseLogsTableUpdateCompanionBuilder,
          (ExpenseLogData, $$ExpenseLogsTableReferences),
          ExpenseLogData,
          PrefetchHooks Function({bool bikeId})
        > {
  $$ExpenseLogsTableTableManager(_$RevMateDatabase db, $ExpenseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bikeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> cost = const Value.absent(),
              }) => ExpenseLogsCompanion(
                id: id,
                bikeId: bikeId,
                date: date,
                category: category,
                description: description,
                cost: cost,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bikeId,
                required DateTime date,
                required ExpenseCategory category,
                required String description,
                required double cost,
              }) => ExpenseLogsCompanion.insert(
                id: id,
                bikeId: bikeId,
                date: date,
                category: category,
                description: description,
                cost: cost,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpenseLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bikeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bikeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bikeId,
                                referencedTable: $$ExpenseLogsTableReferences
                                    ._bikeIdTable(db),
                                referencedColumn: $$ExpenseLogsTableReferences
                                    ._bikeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$RevMateDatabase,
      $ExpenseLogsTable,
      ExpenseLogData,
      $$ExpenseLogsTableFilterComposer,
      $$ExpenseLogsTableOrderingComposer,
      $$ExpenseLogsTableAnnotationComposer,
      $$ExpenseLogsTableCreateCompanionBuilder,
      $$ExpenseLogsTableUpdateCompanionBuilder,
      (ExpenseLogData, $$ExpenseLogsTableReferences),
      ExpenseLogData,
      PrefetchHooks Function({bool bikeId})
    >;
typedef $$RideLogsTableCreateCompanionBuilder =
    RideLogsCompanion Function({
      Value<int> id,
      required int bikeId,
      required DateTime startTime,
      required DateTime endTime,
      required double distanceKm,
      required String routePoints,
      required int startOdometer,
      required int endOdometer,
    });
typedef $$RideLogsTableUpdateCompanionBuilder =
    RideLogsCompanion Function({
      Value<int> id,
      Value<int> bikeId,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<double> distanceKm,
      Value<String> routePoints,
      Value<int> startOdometer,
      Value<int> endOdometer,
    });

final class $$RideLogsTableReferences
    extends BaseReferences<_$RevMateDatabase, $RideLogsTable, RideLogData> {
  $$RideLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BikesTable _bikeIdTable(_$RevMateDatabase db) => db.bikes.createAlias(
    $_aliasNameGenerator(db.rideLogs.bikeId, db.bikes.id),
  );

  $$BikesTableProcessedTableManager get bikeId {
    final $_column = $_itemColumn<int>('bike_id')!;

    final manager = $$BikesTableTableManager(
      $_db,
      $_db.bikes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bikeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RideLogsTableFilterComposer
    extends Composer<_$RevMateDatabase, $RideLogsTable> {
  $$RideLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routePoints => $composableBuilder(
    column: $table.routePoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOdometer => $composableBuilder(
    column: $table.startOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => ColumnFilters(column),
  );

  $$BikesTableFilterComposer get bikeId {
    final $$BikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableFilterComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RideLogsTableOrderingComposer
    extends Composer<_$RevMateDatabase, $RideLogsTable> {
  $$RideLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routePoints => $composableBuilder(
    column: $table.routePoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOdometer => $composableBuilder(
    column: $table.startOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  $$BikesTableOrderingComposer get bikeId {
    final $$BikesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableOrderingComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RideLogsTableAnnotationComposer
    extends Composer<_$RevMateDatabase, $RideLogsTable> {
  $$RideLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get routePoints => $composableBuilder(
    column: $table.routePoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startOdometer => $composableBuilder(
    column: $table.startOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => column,
  );

  $$BikesTableAnnotationComposer get bikeId {
    final $$BikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableAnnotationComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RideLogsTableTableManager
    extends
        RootTableManager<
          _$RevMateDatabase,
          $RideLogsTable,
          RideLogData,
          $$RideLogsTableFilterComposer,
          $$RideLogsTableOrderingComposer,
          $$RideLogsTableAnnotationComposer,
          $$RideLogsTableCreateCompanionBuilder,
          $$RideLogsTableUpdateCompanionBuilder,
          (RideLogData, $$RideLogsTableReferences),
          RideLogData,
          PrefetchHooks Function({bool bikeId})
        > {
  $$RideLogsTableTableManager(_$RevMateDatabase db, $RideLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RideLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RideLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RideLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bikeId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<double> distanceKm = const Value.absent(),
                Value<String> routePoints = const Value.absent(),
                Value<int> startOdometer = const Value.absent(),
                Value<int> endOdometer = const Value.absent(),
              }) => RideLogsCompanion(
                id: id,
                bikeId: bikeId,
                startTime: startTime,
                endTime: endTime,
                distanceKm: distanceKm,
                routePoints: routePoints,
                startOdometer: startOdometer,
                endOdometer: endOdometer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bikeId,
                required DateTime startTime,
                required DateTime endTime,
                required double distanceKm,
                required String routePoints,
                required int startOdometer,
                required int endOdometer,
              }) => RideLogsCompanion.insert(
                id: id,
                bikeId: bikeId,
                startTime: startTime,
                endTime: endTime,
                distanceKm: distanceKm,
                routePoints: routePoints,
                startOdometer: startOdometer,
                endOdometer: endOdometer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RideLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bikeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bikeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bikeId,
                                referencedTable: $$RideLogsTableReferences
                                    ._bikeIdTable(db),
                                referencedColumn: $$RideLogsTableReferences
                                    ._bikeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RideLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$RevMateDatabase,
      $RideLogsTable,
      RideLogData,
      $$RideLogsTableFilterComposer,
      $$RideLogsTableOrderingComposer,
      $$RideLogsTableAnnotationComposer,
      $$RideLogsTableCreateCompanionBuilder,
      $$RideLogsTableUpdateCompanionBuilder,
      (RideLogData, $$RideLogsTableReferences),
      RideLogData,
      PrefetchHooks Function({bool bikeId})
    >;

class $RevMateDatabaseManager {
  final _$RevMateDatabase _db;
  $RevMateDatabaseManager(this._db);
  $$BikesTableTableManager get bikes =>
      $$BikesTableTableManager(_db, _db.bikes);
  $$FuelLogsTableTableManager get fuelLogs =>
      $$FuelLogsTableTableManager(_db, _db.fuelLogs);
  $$ServiceLogsTableTableManager get serviceLogs =>
      $$ServiceLogsTableTableManager(_db, _db.serviceLogs);
  $$ExpenseLogsTableTableManager get expenseLogs =>
      $$ExpenseLogsTableTableManager(_db, _db.expenseLogs);
  $$RideLogsTableTableManager get rideLogs =>
      $$RideLogsTableTableManager(_db, _db.rideLogs);
}
