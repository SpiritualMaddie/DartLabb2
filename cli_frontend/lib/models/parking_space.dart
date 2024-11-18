class ParkingSpace {
  //int parkingSpaceId;
  String zone;
  int pricePerHour;

  ParkingSpace({required this.zone, required this.pricePerHour});

  @override
  String toString() {
    return """
Zone: $zone
    ${pricePerHour} kr/h
---------------------------------""";
  }

  Map<String, dynamic> toJson() => {
  'zone' : zone,
  'pricePerHour' : pricePerHour
  };
}
