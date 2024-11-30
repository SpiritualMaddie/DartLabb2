import 'package:cli_server/repositories/parking_repository.dart';
import 'package:cli_server/repositories/parking_space_repository.dart';
import 'package:cli_server/repositories/person_repository.dart';
import 'package:cli_server/repositories/vehicle_repository.dart';

import 'package:shared/models/vehicle.dart';
import 'package:shared/models/parking.dart';
import 'package:shared/models/parking_space.dart';
import 'package:shared/models/person.dart';

class DummyData{

  static final DummyData _instance = DummyData._internal();
  DummyData._internal();

  factory DummyData() => _instance;

  void populateDb(){

    // Check if "Db" is populated and if not then populate
    // if ()) {
      
    // }

    // ************************* INSTANCES OF REPOS *********************************************************
    var repoPerson = PersonRepository();
    var repoVehicle = VehicleRepository();
    var repoParkingSpace = ParkingSpaceRepository();
    var repoParking = ParkingRepository();

    // ************************* PERSONS ********************************************************************
    var person101 = Person(personId: 101, ssn: "19850124-8595", firstName: "Dean", lastName: "Winchester");
    repoPerson.create(person101);
    var person102 = Person(personId: 102, ssn: "19830502-1234", firstName: "Sam", lastName: "Winchester");
    repoPerson.create(person102);
    var person103 = Person(personId: 103, ssn: "90000101-0000", firstName: "The", lastName: "Doctor");
    repoPerson.create(person103);
    var person104 = Person(personId: 104, ssn: "19850921-1985", firstName: "Clara", lastName: "Oswald");
    repoPerson.create(person104);
    var person105 = Person(personId: 105, ssn: "19740706-7474", firstName: "Sherlock", lastName: "Holmes");
    repoPerson.create(person105);
    var person106 = Person(personId: 106, ssn: "19721117-1117", firstName: "John", lastName: "Watson");
    repoPerson.create(person106);
    var person107 = Person(personId: 107, ssn: "29721231-1231", firstName: "Philip", lastName: "Fry");
    repoPerson.create(person107);
    var person108 = Person(personId: 108, ssn: "29951225-2995", firstName: "Leela", lastName: "Turanga");
    repoPerson.create(person108);
    var person109 = Person(personId: 109, ssn: "19461022-4200", firstName: "Rick", lastName: "Sanchez");
    repoPerson.create(person109);
    var person110 = Person(personId: 110, ssn: "20041205-0504", firstName: "Morty", lastName: "Smith");
    repoPerson.create(person110);


    // ************************* VEHICLES *******************************************************************
    var vehicle201 = Vehicle(vehicleId: 201, plateNumber: "KAZ2Y5", vehicleType: "Bil", owner: person101);
    repoVehicle.create(vehicle201);
    var vehicle202 = Vehicle(vehicleId: 202, plateNumber: "SLAYER666", vehicleType: "Bil", owner: person102);
    repoVehicle.create(vehicle202);
    var vehicle203 = Vehicle(vehicleId: 203, plateNumber: "TARDIS001", vehicleType: "TARDIS", owner: person103);
    repoVehicle.create(vehicle203);
    var vehicle204 = Vehicle(vehicleId: 204, plateNumber: "GOV001", vehicleType: "Motorcycle", owner: person104);
    repoVehicle.create(vehicle204);
    var vehicle205 = Vehicle(vehicleId: 205, plateNumber: "221BBKR", vehicleType: "Bil", owner: person105);
    repoVehicle.create(vehicle205);
    var vehicle206 = Vehicle(vehicleId: 206, plateNumber: "HND978", vehicleType: "Bil", owner: person106);
    repoVehicle.create(vehicle206);
    var vehicle207 = Vehicle(vehicleId: 207, plateNumber: "PLANETEXP", vehicleType: "Spaceship", owner: person107);
    repoVehicle.create(vehicle207);
    var vehicle208 = Vehicle(vehicleId: 208, plateNumber: "1EYEDRVR", vehicleType: "Hovercar", owner: person108);
    repoVehicle.create(vehicle208);
    var vehicle209 = Vehicle(vehicleId: 209, plateNumber: "C137SHIP", vehicleType: "Spaceship", owner: person109);
    repoVehicle.create(vehicle209);
    var vehicle210 = Vehicle(vehicleId: 210, plateNumber: "AWEHUMAN", vehicleType: "Hovercar", owner: person110);
    repoVehicle.create(vehicle210);


    // ************************* PARKING SPACES *************************************************************
    var parkingSpace301 = ParkingSpace(parkingSpaceId: 301, zone: "GhostPlace", pricePerHour: 10);
    repoParkingSpace.create(parkingSpace301);
    var parkingSpace302 = ParkingSpace(parkingSpaceId: 302, zone: "Hell's Lot", pricePerHour: 666);
    repoParkingSpace.create(parkingSpace302);
    var parkingSpace303 = ParkingSpace(parkingSpaceId: 303, zone: "Time Traveler's Bay", pricePerHour: 11);
    repoParkingSpace.create(parkingSpace303);
    var parkingSpace304 = ParkingSpace(parkingSpaceId: 304, zone: "Void", pricePerHour: 22);
    repoParkingSpace.create(parkingSpace304);
    var parkingSpace305 = ParkingSpace(parkingSpaceId: 305, zone: "Baker Street 221B", pricePerHour: 5);
    repoParkingSpace.create(parkingSpace305);
    var parkingSpace306 = ParkingSpace(parkingSpaceId: 306, zone: "Moriarty's Hideout", pricePerHour: 500);
    repoParkingSpace.create(parkingSpace306);
    var parkingSpace307 = ParkingSpace(parkingSpaceId: 307, zone: "Planet Express HQ", pricePerHour: 25);
    repoParkingSpace.create(parkingSpace307);
    var parkingSpace308 = ParkingSpace(parkingSpaceId: 308, zone: "Cryogenic Storage Lot", pricePerHour: 1999);
    repoParkingSpace.create(parkingSpace308);
    var parkingSpace309 = ParkingSpace(parkingSpaceId: 309, zone: "Citadel of Ricks", pricePerHour: 420);
    repoParkingSpace.create(parkingSpace309);
    var parkingSpace310 = ParkingSpace(parkingSpaceId: 310, zone: "Schwifty Zone", pricePerHour: 69);
    repoParkingSpace.create(parkingSpace310);


    // ************************* PARKINGS *******************************************************************
    repoParking.create(Parking(parkingId: 401, vehicle: vehicle201, parkingSpace: parkingSpace301, startTime: DateTime(2024, 10, 10, 13, 0), endTime: DateTime(2024, 10, 10, 15, 30)));
    repoParking.create(Parking(parkingId: 402, vehicle: vehicle202, parkingSpace: parkingSpace302, startTime: DateTime(2024, 10, 10, 1, 0)));
    repoParking.create(Parking(parkingId: 403, vehicle: vehicle207, parkingSpace: parkingSpace307, startTime: DateTime(2024, 10, 10, 10, 0), endTime: DateTime(2024, 10, 10, 12, 30)));
    repoParking.create(Parking(parkingId: 404, vehicle: vehicle210, parkingSpace: parkingSpace307, startTime: DateTime(2024, 10, 9, 18, 0)));
    repoParking.create(Parking(parkingId: 405, vehicle: vehicle203, parkingSpace: parkingSpace309, startTime: DateTime(2024, 10, 10, 23, 45), endTime: DateTime(2024, 10, 11, 3, 30)));
  }
}