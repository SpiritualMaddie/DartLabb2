import 'package:shared/models/parking_space.dart';
import 'package:shared/models/vehicle.dart';

class Parking {
  int parkingId;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking(
      { required this.parkingId,
      required this.vehicle,
      required this.parkingSpace,
      required this.startTime,
      this.endTime});

  String get endTimeStatus {
    return endTime != null ? endTime.toString() : "pågående";
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} - "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  String toString() {
    String formattedStartTime = formatDateTime(startTime);
    String formattedEndTime =
        endTime != null ? formatDateTime(endTime!) : "pågående";

    return """
 Fordon: ${vehicle.plateNumber} - ${vehicle.vehicleType}
    Zone: ${parkingSpace.zone}
    Starttid: $formattedStartTime
    Sluttid:  $formattedEndTime
    Parkingsid: $parkingId
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    'parkingId' : parkingId,
    'vehicle' : vehicle.toJson(),
    'parkingSpace' : parkingSpace.toJson(),
    'startTime' : startTime.toIso8601String(),
    'endTime' : endTime?.toIso8601String()
  };

  // Deserialization
  factory Parking.fromJson(Map<String, dynamic> json){

    if(json['parkingId'] == null || json['vehicle'] == null || json['parkingSpace'] == null || json['startTime'] == null){
      throw FormatException('Missing required fields: parkingId, vehicle, parkingSpace or startTime');
    }
    return Parking(
      parkingId: json['parkingId'],
      vehicle: Vehicle.fromJson(json['vehicle']),
      parkingSpace: ParkingSpace.fromJson(json['parkingSpace']),
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null
      );
  }
}