import 'package:cli_server/repositories/parking_repository.dart';
import 'package:cli_server/repositories/parking_space_repository.dart';
import 'package:cli_server/repositories/person_repository.dart';
import 'package:cli_server/repositories/vehicle_repository.dart';

import 'package:shared/shared.dart';

class DummyData{

  static final DummyData _instance = DummyData._internal();
  DummyData._internal();

  factory DummyData() => _instance;

  // ************************* INSTANCES OF REPOS *********************************************************
  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();
  
  void seedData(){

    // Check if "Db" is populated and if not then populate
    if (repoPerson.personBox.isEmpty()) {
      
      // ************************* PERSONS ********************************************************************
      repoPerson.create(Person(ssn: "19850124-8595", firstName: "Dean", lastName: "Winchester"));
      repoPerson.create(Person(ssn: "19830502-1234", firstName: "Sam", lastName: "Winchester"));
      repoPerson.create(Person(ssn: "90000101-0000", firstName: "The", lastName: "Doctor"));
      repoPerson.create(Person(ssn: "19850921-1985", firstName: "Clara", lastName: "Oswald"));
      repoPerson.create(Person(ssn: "19740706-7474", firstName: "Sherlock", lastName: "Holmes"));
      repoPerson.create(Person(ssn: "19721117-1117", firstName: "John", lastName: "Watson"));
      repoPerson.create(Person(ssn: "29721231-1231", firstName: "Philip", lastName: "Fry"));
      repoPerson.create(Person(ssn: "29951225-2995", firstName: "Leela", lastName: "Turanga"));
      repoPerson.create(Person(ssn: "19461022-4200", firstName: "Rick", lastName: "Sanchez"));
      repoPerson.create(Person(ssn: "20041205-0504", firstName: "Morty", lastName: "Smith"));
    }

    if(repoVehicle.vehicleBox.isEmpty()){

      // ************************* VEHICLES *******************************************************************
      repoVehicle.create(Vehicle(licensePlate: "KAZ2Y5", vehicleType: "Bil", personId: 101));
      repoVehicle.create(Vehicle(licensePlate: "SLAYER666", vehicleType: "Bil", personId: 102));
      repoVehicle.create(Vehicle(licensePlate: "TARDIS001", vehicleType: "TARDIS", personId: 103));
      repoVehicle.create(Vehicle(licensePlate: "GOV001", vehicleType: "Motorcycle", personId: 104));
      repoVehicle.create(Vehicle(licensePlate: "221BBKR", vehicleType: "Bil", personId: 105));
      repoVehicle.create(Vehicle(licensePlate: "HND978", vehicleType: "Bil", personId: 106));
      repoVehicle.create(Vehicle(licensePlate: "PLANETEXP", vehicleType: "Spaceship", personId: 107));
      repoVehicle.create(Vehicle(licensePlate: "1EYEDRVR", vehicleType: "Hovercar", personId: 108));
      repoVehicle.create(Vehicle(licensePlate: "C137SHIP", vehicleType: "Spaceship", personId: 109));
      repoVehicle.create(Vehicle(licensePlate: "AWEHUMAN", vehicleType: "Hovercar", personId: 110));
    }

    if(repoParkingSpace.parkingSpaceBox.isEmpty()){

      // ************************* PARKING SPACES *************************************************************
      repoParkingSpace.create(ParkingSpace(zone: "GhostPlace", pricePerHour: 10));
      repoParkingSpace.create(ParkingSpace(zone: "Hell's Lot", pricePerHour: 666));
      repoParkingSpace.create(ParkingSpace(zone: "Time Traveler's Bay", pricePerHour: 11));
      repoParkingSpace.create(ParkingSpace(zone: "Void", pricePerHour: 22));
      repoParkingSpace.create(ParkingSpace(zone: "Baker Street 221B", pricePerHour: 5));
      repoParkingSpace.create(ParkingSpace(zone: "Moriarty's Hideout", pricePerHour: 500));
      repoParkingSpace.create(ParkingSpace(zone: "Planet Express HQ", pricePerHour: 25));
      repoParkingSpace.create(ParkingSpace(zone: "Cryogenic Storage Lot", pricePerHour: 1999));
      repoParkingSpace.create(ParkingSpace(zone: "Citadel of Ricks", pricePerHour: 420));
      repoParkingSpace.create(ParkingSpace(zone: "Schwifty Zone", pricePerHour: 69));
    }

    if(repoParking.parkingBox.isEmpty()){

      // ************************* PARKINGS *******************************************************************
      repoParking.create(Parking(vehicleId: 1, parkingSpaceId: 1, startTime: DateTime(2024, 10, 10, 13, 0), endTime: DateTime(2024, 10, 10, 15, 30)));
      repoParking.create(Parking(vehicleId: 2, parkingSpaceId: 2, startTime: DateTime(2024, 10, 10, 1, 0)));
      repoParking.create(Parking(vehicleId: 7, parkingSpaceId: 7, startTime: DateTime(2024, 10, 10, 10, 0), endTime: DateTime(2024, 10, 10, 12, 30)));
      repoParking.create(Parking(vehicleId: 10, parkingSpaceId: 7, startTime: DateTime(2024, 10, 9, 18, 0)));
      repoParking.create(Parking(vehicleId: 3, parkingSpaceId: 9, startTime: DateTime(2024, 10, 10, 23, 45), endTime: DateTime(2024, 10, 11, 3, 30)));
    }
  }
}