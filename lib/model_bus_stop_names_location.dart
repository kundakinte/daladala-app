class myLocation {
  final double lat;
  final double lng;

  myLocation({required this.lat, required this.lng});

  factory myLocation.fromJson(Map<dynamic, dynamic> parsedJson) {
    return myLocation(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}
