import 'package:shared/shared.dart';

@Entity()
class Parking {

  @Id()
  int parkingId;

  int vehicleId;
  int parkingSpaceId;

  @Property(type: PropertyType.date)
  DateTime startTime;

  @Property(type: PropertyType.date)
  DateTime? endTime;

  Parking(
      { this.parkingId = 0,
      required this.vehicleId,
      required this.parkingSpaceId,
      required this.startTime,
      this.endTime});

  @Transient()
  String get endTimeStatus {
    return endTime != null ? endTime.toString() : "pågående";
  }

  // Formatting date
  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} - "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  // Detailed string
  String toDetailedString(Vehicle vehicle, ParkingSpace parkingSpace) {
    String formattedStartTime = formatDateTime(startTime);
    String formattedEndTime =
        endTime != null ? formatDateTime(endTime!) : "pågående";

    return """
 Fordon: ${vehicle.licensePlate} - ${vehicle.vehicleType}
    Zone: ${parkingSpace.zone}
    Starttid: $formattedStartTime
    Sluttid:  $formattedEndTime
    Parkingsid: $parkingId
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    'parkingId' : parkingId,
    'vehicleId' : vehicleId,
    'parkingSpaceId' : parkingSpaceId,
    'startTime' : startTime.toIso8601String(),
    'endTime' : endTime?.toIso8601String()
  };

  // Deserialization
  factory Parking.fromJson(Map<String, dynamic> json){
    
    List<String> missingFields = [];
    if (json['parkingId'] == null) missingFields.add('parkingId');
    if (json['vehicleId'] == null) missingFields.add('vehicleId');
    if (json['parkingSpaceId'] == null) missingFields.add('parkingSpaceId');
    if (json['startTime'] == null) missingFields.add('startTime');

    if (missingFields.isNotEmpty) {
      throw FormatException('Missing required fields: ${missingFields.join(', ')}');
    }

    return Parking(
      parkingId: json['parkingId'],
      vehicleId: json['vehicleId'],
      parkingSpaceId: json['parkingSpaceId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }
}