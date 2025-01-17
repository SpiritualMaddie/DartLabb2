import 'package:shared/shared.dart';

@Entity()
class Vehicle {

  @Id()
  int vehicleId;

  @Index()
  @Unique()
  String licensePlate;

  String vehicleType;
  int personId;

  Vehicle({this.vehicleId = 0, required this.licensePlate, required this.vehicleType, required this.personId});

  @override
  String toString() {
    return """
Id: $vehicleId
Fordon: $vehicleType
Regnr: $licensePlate
Ägarid: $personId
-----------------------------------------------------------""";
  }

  String toDetailedString(Person owner) {
    return """
Id: $vehicleId
Regnr: $licensePlate
Typ: $vehicleType
Ägare: ${owner.firstName} ${owner.lastName}
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    'vehicleId' : vehicleId,
    'licensePlate' : licensePlate,
    'vehicleType' : vehicleType,
    'personId' : personId
  };

  // Deserialization
  factory Vehicle.fromJson(Map<String, dynamic> json){

    List<String> missingFields = [];
    if (json['vehicleId'] == null) missingFields.add('vehicleId');
    if (json['licensePlate'] == null) missingFields.add('licensePlate');
    if (json['vehicleType'] == null) missingFields.add('vehicleType');
    if (json['personId'] == null) missingFields.add('personId');

    if (missingFields.isNotEmpty) {
      throw FormatException('Missing required fields: ${missingFields.join(', ')}');
    }

    return Vehicle(
      vehicleId: json['vehicleId'],
      licensePlate: json['licensePlate'],
      vehicleType: json['vehicleType'],
      personId: json['personId']
      );
  }
}