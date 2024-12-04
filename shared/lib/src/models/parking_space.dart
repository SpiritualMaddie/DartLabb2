import 'package:shared/shared.dart';

@Entity()
class ParkingSpace {

  @Id()
  int parkingSpaceId;

  @Index()
  @Unique()
  String zone;

  int pricePerHour;

  ParkingSpace({this.parkingSpaceId = 0, required this.zone, required this.pricePerHour});

  @override
  String toString() {
    return """
Id: $parkingSpaceId
Zone: $zone
    $pricePerHour kr/h
---------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
  'parkingSpaceId' : parkingSpaceId,
  'zone' : zone,
  'pricePerHour' : pricePerHour
  };

  // Deserialization
  factory ParkingSpace.fromJson(Map<String, dynamic> json){
    
    List<String> missingFields = [];
    if (json['parkingSpaceId'] == null) missingFields.add('parkingSpaceId');
    if (json['zone'] == null) missingFields.add('zone');
    if (json['pricePerHour'] == null) missingFields.add('pricePerHour');

    if (missingFields.isNotEmpty) {
      throw FormatException('Missing required fields: ${missingFields.join(', ')}');
    }

    return ParkingSpace(
      parkingSpaceId: json['parkingSpaceId'],
      zone: json['zone'],
      pricePerHour: (json['pricePerHour'] as num).toInt()
      );
  }
}
