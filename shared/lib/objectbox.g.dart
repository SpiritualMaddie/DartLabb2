// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;

import 'src/models/parking.dart';
import 'src/models/parking_space.dart';
import 'src/models/person.dart';
import 'src/models/vehicle.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 8813278382504450044),
      name: 'Parking',
      lastPropertyId: const obx_int.IdUid(5, 9089586944744605830),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1054291407934747467),
            name: 'parkingId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 8261744685013495795),
            name: 'vehicleId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6675024368437381081),
            name: 'parkingSpaceId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 368220378176999348),
            name: 'startTime',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 9089586944744605830),
            name: 'endTime',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 2802030470917105127),
      name: 'ParkingSpace',
      lastPropertyId: const obx_int.IdUid(3, 4217450996734641682),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2850797435141281359),
            name: 'parkingSpaceId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1295701247449746109),
            name: 'zone',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(1, 2399757540996129407)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4217450996734641682),
            name: 'pricePerHour',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 3122394886171549603),
      name: 'Person',
      lastPropertyId: const obx_int.IdUid(4, 7792661337210738585),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7668233124982489943),
            name: 'personId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5647823722432396794),
            name: 'ssn',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(2, 4220741583115160244)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2645269114498255014),
            name: 'firstName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 7792661337210738585),
            name: 'lastName',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 446804112746256073),
      name: 'Vehicle',
      lastPropertyId: const obx_int.IdUid(4, 1964154500027499895),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2251032890364106058),
            name: 'vehicleId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1927915591024465372),
            name: 'licensePlate',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(3, 478052851836227630)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8212401710207171530),
            name: 'vehicleType',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 1964154500027499895),
            name: 'personId',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
obx.Store openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) {
  return obx.Store(getObjectBoxModel(),
      directory: directory,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(4, 446804112746256073),
      lastIndexId: const obx_int.IdUid(3, 478052851836227630),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Parking: obx_int.EntityDefinition<Parking>(
        model: _entities[0],
        toOneRelations: (Parking object) => [],
        toManyRelations: (Parking object) => {},
        getId: (Parking object) => object.parkingId,
        setId: (Parking object, int id) {
          object.parkingId = id;
        },
        objectToFB: (Parking object, fb.Builder fbb) {
          fbb.startTable(6);
          fbb.addInt64(0, object.parkingId);
          fbb.addInt64(1, object.vehicleId);
          fbb.addInt64(2, object.parkingSpaceId);
          fbb.addInt64(3, object.startTime.millisecondsSinceEpoch);
          fbb.addInt64(4, object.endTime?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.parkingId;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final endTimeValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final parkingIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final vehicleIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final parkingSpaceIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final startTimeParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));
          final endTimeParam = endTimeValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(endTimeValue);
          final object = Parking(
              parkingId: parkingIdParam,
              vehicleId: vehicleIdParam,
              parkingSpaceId: parkingSpaceIdParam,
              startTime: startTimeParam,
              endTime: endTimeParam);

          return object;
        }),
    ParkingSpace: obx_int.EntityDefinition<ParkingSpace>(
        model: _entities[1],
        toOneRelations: (ParkingSpace object) => [],
        toManyRelations: (ParkingSpace object) => {},
        getId: (ParkingSpace object) => object.parkingSpaceId,
        setId: (ParkingSpace object, int id) {
          object.parkingSpaceId = id;
        },
        objectToFB: (ParkingSpace object, fb.Builder fbb) {
          final zoneOffset = fbb.writeString(object.zone);
          fbb.startTable(4);
          fbb.addInt64(0, object.parkingSpaceId);
          fbb.addOffset(1, zoneOffset);
          fbb.addInt64(2, object.pricePerHour);
          fbb.finish(fbb.endTable());
          return object.parkingSpaceId;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final parkingSpaceIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final zoneParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final pricePerHourParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final object = ParkingSpace(
              parkingSpaceId: parkingSpaceIdParam,
              zone: zoneParam,
              pricePerHour: pricePerHourParam);

          return object;
        }),
    Person: obx_int.EntityDefinition<Person>(
        model: _entities[2],
        toOneRelations: (Person object) => [],
        toManyRelations: (Person object) => {},
        getId: (Person object) => object.personId,
        setId: (Person object, int id) {
          object.personId = id;
        },
        objectToFB: (Person object, fb.Builder fbb) {
          final ssnOffset = fbb.writeString(object.ssn);
          final firstNameOffset = fbb.writeString(object.firstName);
          final lastNameOffset = fbb.writeString(object.lastName);
          fbb.startTable(5);
          fbb.addInt64(0, object.personId);
          fbb.addOffset(1, ssnOffset);
          fbb.addOffset(2, firstNameOffset);
          fbb.addOffset(3, lastNameOffset);
          fbb.finish(fbb.endTable());
          return object.personId;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final personIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final ssnParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final firstNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final lastNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = Person(
              personId: personIdParam,
              ssn: ssnParam,
              firstName: firstNameParam,
              lastName: lastNameParam);

          return object;
        }),
    Vehicle: obx_int.EntityDefinition<Vehicle>(
        model: _entities[3],
        toOneRelations: (Vehicle object) => [],
        toManyRelations: (Vehicle object) => {},
        getId: (Vehicle object) => object.vehicleId,
        setId: (Vehicle object, int id) {
          object.vehicleId = id;
        },
        objectToFB: (Vehicle object, fb.Builder fbb) {
          final licensePlateOffset = fbb.writeString(object.licensePlate);
          final vehicleTypeOffset = fbb.writeString(object.vehicleType);
          fbb.startTable(5);
          fbb.addInt64(0, object.vehicleId);
          fbb.addOffset(1, licensePlateOffset);
          fbb.addOffset(2, vehicleTypeOffset);
          fbb.addInt64(3, object.personId);
          fbb.finish(fbb.endTable());
          return object.vehicleId;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final vehicleIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final licensePlateParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final vehicleTypeParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, '');
          final personIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final object = Vehicle(
              vehicleId: vehicleIdParam,
              licensePlate: licensePlateParam,
              vehicleType: vehicleTypeParam,
              personId: personIdParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Parking] entity fields to define ObjectBox queries.
class Parking_ {
  /// See [Parking.parkingId].
  static final parkingId =
      obx.QueryIntegerProperty<Parking>(_entities[0].properties[0]);

  /// See [Parking.vehicleId].
  static final vehicleId =
      obx.QueryIntegerProperty<Parking>(_entities[0].properties[1]);

  /// See [Parking.parkingSpaceId].
  static final parkingSpaceId =
      obx.QueryIntegerProperty<Parking>(_entities[0].properties[2]);

  /// See [Parking.startTime].
  static final startTime =
      obx.QueryDateProperty<Parking>(_entities[0].properties[3]);

  /// See [Parking.endTime].
  static final endTime =
      obx.QueryDateProperty<Parking>(_entities[0].properties[4]);
}

/// [ParkingSpace] entity fields to define ObjectBox queries.
class ParkingSpace_ {
  /// See [ParkingSpace.parkingSpaceId].
  static final parkingSpaceId =
      obx.QueryIntegerProperty<ParkingSpace>(_entities[1].properties[0]);

  /// See [ParkingSpace.zone].
  static final zone =
      obx.QueryStringProperty<ParkingSpace>(_entities[1].properties[1]);

  /// See [ParkingSpace.pricePerHour].
  static final pricePerHour =
      obx.QueryIntegerProperty<ParkingSpace>(_entities[1].properties[2]);
}

/// [Person] entity fields to define ObjectBox queries.
class Person_ {
  /// See [Person.personId].
  static final personId =
      obx.QueryIntegerProperty<Person>(_entities[2].properties[0]);

  /// See [Person.ssn].
  static final ssn =
      obx.QueryStringProperty<Person>(_entities[2].properties[1]);

  /// See [Person.firstName].
  static final firstName =
      obx.QueryStringProperty<Person>(_entities[2].properties[2]);

  /// See [Person.lastName].
  static final lastName =
      obx.QueryStringProperty<Person>(_entities[2].properties[3]);
}

/// [Vehicle] entity fields to define ObjectBox queries.
class Vehicle_ {
  /// See [Vehicle.vehicleId].
  static final vehicleId =
      obx.QueryIntegerProperty<Vehicle>(_entities[3].properties[0]);

  /// See [Vehicle.licensePlate].
  static final licensePlate =
      obx.QueryStringProperty<Vehicle>(_entities[3].properties[1]);

  /// See [Vehicle.vehicleType].
  static final vehicleType =
      obx.QueryStringProperty<Vehicle>(_entities[3].properties[2]);

  /// See [Vehicle.personId].
  static final personId =
      obx.QueryIntegerProperty<Vehicle>(_entities[3].properties[3]);
}
