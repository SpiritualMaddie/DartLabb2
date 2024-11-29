class ParkingSpace {
  int parkingSpaceId;
  String zone;
  int pricePerHour;

  ParkingSpace({required this.parkingSpaceId, required this.zone, required this.pricePerHour});

  @override
  String toString() {
    return """
Id: $parkingSpaceId
Zone: $zone
    $pricePerHour kr/h
---------------------------------""";
  }

  Map<String, dynamic> toJson() => {
  'parkingSpaceId' : parkingSpaceId,
  'zone' : zone,
  'pricePerHour' : pricePerHour
  };

  // Deserialization
  factory ParkingSpace.fromJson(Map<String, dynamic> json){

    if(json['parkingSpaceId'] == null || json['zone'] == null || json['pricePerHour'] == null){
      throw FormatException('Missing required fields: zone or pricePerHour');
    }
    return ParkingSpace(
      parkingSpaceId: json['parkingSpaceId'],
      zone: json['zone'],
      pricePerHour: (json['pricePerHour'] as num).toInt()
      );
  }
}
