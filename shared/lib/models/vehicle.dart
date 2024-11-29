import 'package:shared/models/person.dart';

class Vehicle {
  int vehicleId;
  String plateNumber;
  String vehicleType;
  Person owner;

  Vehicle({required this.vehicleId, required this.plateNumber, required this.vehicleType, required this.owner});

  @override
  String toString() {
    return """
Id: $vehicleId
Regnr: $plateNumber
    Typ: $vehicleType
    Ägare: ${owner.firstName} ${owner.lastName}
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    'vehicleId' : vehicleId,
    'plateNumber' : plateNumber,
    'vehicleType' : vehicleType,
    'owner' : owner.toJson()
  };

  // Deserialization
  factory Vehicle.fromJson(Map<String, dynamic> json){

    if(json['vehicleId'] == null || json['plateNumber'] == null || json['vehicleType'] == null || json['owner'] == null){
      throw FormatException('Missing required fields: vehicleId, plateNumber, vehicleType or owner');
    }
    return Vehicle(
      vehicleId: json['vehicleId'],
      plateNumber: json['plateNumber'],
      vehicleType: json['vehicleType'],
      owner: Person.fromJson(json['owner'])
      );
  }
}