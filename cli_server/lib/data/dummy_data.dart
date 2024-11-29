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
    repoPerson.add(person101);
    var person102 = Person(personId: 102, ssn: "19830502-1234", firstName: "Sam", lastName: "Winchester");
    repoPerson.add(person102);
    var person103 = Person(personId: 103, ssn: "90000101-0000", firstName: "The", lastName: "Doctor");
    repoPerson.add(person103);
    var person104 = Person(personId: 104, ssn: "19850921-1985", firstName: "Clara", lastName: "Oswald");
    repoPerson.add(person104);
    var person105 = Person(personId: 105, ssn: "19740706-7474", firstName: "Sherlock", lastName: "Holmes");
    repoPerson.add(person105);
    var person106 = Person(personId: 106, ssn: "19721117-1117", firstName: "John", lastName: "Watson");
    repoPerson.add(person106);
    var person107 = Person(personId: 107, ssn: "29721231-1231", firstName: "Philip", lastName: "Fry");
    repoPerson.add(person107);
    var person108 = Person(personId: 108, ssn: "29951225-2995", firstName: "Leela", lastName: "Turanga");
    repoPerson.add(person108);
    var person109 = Person(personId: 109, ssn: "19461022-4200", firstName: "Rick", lastName: "Sanchez");
    repoPerson.add(person109);
    var person110 = Person(personId: 110, ssn: "20041205-0504", firstName: "Morty", lastName: "Smith");
    repoPerson.add(person110);


    // ************************* VEHICLES *******************************************************************
    var vehicle201 = Vehicle(vehicleId: 201, plateNumber: "KAZ2Y5", vehicleType: "Bil", owner: person101);
    repoVehicle.add(vehicle201);
    var vehicle202 = Vehicle(vehicleId: 202, plateNumber: "SLAYER666", vehicleType: "Bil", owner: person102);
    repoVehicle.add(vehicle202);
    var vehicle203 = Vehicle(vehicleId: 203, plateNumber: "TARDIS001", vehicleType: "TARDIS", owner: person103);
    repoVehicle.add(vehicle203);
    var vehicle204 = Vehicle(vehicleId: 204, plateNumber: "GOV001", vehicleType: "Motorcycle", owner: person104);
    repoVehicle.add(vehicle204);
    var vehicle205 = Vehicle(vehicleId: 205, plateNumber: "221BBKR", vehicleType: "Bil", owner: person105);
    repoVehicle.add(vehicle205);
    var vehicle206 = Vehicle(vehicleId: 206, plateNumber: "HND978", vehicleType: "Bil", owner: person106);
    repoVehicle.add(vehicle206);
    var vehicle207 = Vehicle(vehicleId: 207, plateNumber: "PLANETEXP", vehicleType: "Spaceship", owner: person107);
    repoVehicle.add(vehicle207);
    var vehicle208 = Vehicle(vehicleId: 208, plateNumber: "1EYEDRVR", vehicleType: "Hovercar", owner: person108);
    repoVehicle.add(vehicle208);
    var vehicle209 = Vehicle(vehicleId: 209, plateNumber: "C137SHIP", vehicleType: "Spaceship", owner: person109);
    repoVehicle.add(vehicle209);
    var vehicle210 = Vehicle(vehicleId: 210, plateNumber: "AWEHUMAN", vehicleType: "Hovercar", owner: person110);
    repoVehicle.add(vehicle210);


    // ************************* PARKING SPACES *************************************************************
    var parkingSpace301 = ParkingSpace(parkingSpaceId: 301, zone: "GhostPlace", pricePerHour: 10);
    repoParkingSpace.add(parkingSpace301);
    var parkingSpace302 = ParkingSpace(parkingSpaceId: 302, zone: "Hell's Lot", pricePerHour: 666);
    repoParkingSpace.add(parkingSpace302);
    var parkingSpace303 = ParkingSpace(parkingSpaceId: 303, zone: "Time Traveler's Bay", pricePerHour: 11);
    repoParkingSpace.add(parkingSpace303);
    var parkingSpace304 = ParkingSpace(parkingSpaceId: 304, zone: "Void", pricePerHour: 22);
    repoParkingSpace.add(parkingSpace304);
    var parkingSpace305 = ParkingSpace(parkingSpaceId: 305, zone: "Baker Street 221B", pricePerHour: 5);
    repoParkingSpace.add(parkingSpace305);
    var parkingSpace306 = ParkingSpace(parkingSpaceId: 306, zone: "Moriarty's Hideout", pricePerHour: 500);
    repoParkingSpace.add(parkingSpace306);
    var parkingSpace307 = ParkingSpace(parkingSpaceId: 307, zone: "Planet Express HQ", pricePerHour: 25);
    repoParkingSpace.add(parkingSpace307);
    var parkingSpace308 = ParkingSpace(parkingSpaceId: 308, zone: "Cryogenic Storage Lot", pricePerHour: 1999);
    repoParkingSpace.add(parkingSpace308);
    var parkingSpace309 = ParkingSpace(parkingSpaceId: 309, zone: "Citadel of Ricks", pricePerHour: 420);
    repoParkingSpace.add(parkingSpace309);
    var parkingSpace310 = ParkingSpace(parkingSpaceId: 310, zone: "Schwifty Zone", pricePerHour: 69);
    repoParkingSpace.add(parkingSpace310);


    // ************************* PARKINGS *******************************************************************
    repoParking.add(Parking(parkingId: 401, vehicle: vehicle201, parkingSpace: parkingSpace301, startTime: DateTime(2024, 10, 10, 13, 0), endTime: DateTime(2024, 10, 10, 15, 30)));
    repoParking.add(Parking(parkingId: 402, vehicle: vehicle202, parkingSpace: parkingSpace302, startTime: DateTime(2024, 10, 10, 1, 0)));
    repoParking.add(Parking(parkingId: 403, vehicle: vehicle207, parkingSpace: parkingSpace307, startTime: DateTime(2024, 10, 10, 10, 0), endTime: DateTime(2024, 10, 10, 12, 30)));
    repoParking.add(Parking(parkingId: 404, vehicle: vehicle210, parkingSpace: parkingSpace307, startTime: DateTime(2024, 10, 9, 18, 0)));
    repoParking.add(Parking(parkingId: 405, vehicle: vehicle203, parkingSpace: parkingSpace309, startTime: DateTime(2024, 10, 10, 23, 45), endTime: DateTime(2024, 10, 11, 3, 30)));
  }
}