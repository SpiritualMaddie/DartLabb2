

import 'person.dart';


class Vehicle {
  //int vehicleId;
  //enum vehicleType {};
  String plateNumber;
  String vehicleType;
  Person owner;

  Vehicle({required this.plateNumber, required this.vehicleType, required this.owner});

  @override
  String toString() {
    return """
Regnr: $plateNumber
    Typ: $vehicleType
    Ägare: ${owner.firstName} ${owner.lastName}
-----------------------------------------------------------""";
  }

  Map<String, dynamic> toJson() => {
    'plateNumber' : plateNumber,
    'vehicleType' : vehicleType,
    'owner' : {
        'ssn' : owner.ssn,
        'firstname' : owner.firstName,
        'lastname' : owner.lastName
    }
  };
}