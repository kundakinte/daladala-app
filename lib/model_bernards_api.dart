import 'package:google_maps_webservice/directions.dart';

class routes {
  final int fare;
  final String waypoints;
  final String label;

  routes({required this.fare, required this.waypoints, required this.label});

  factory routes.fromJson(Map<String, dynamic> json) {
    return routes(
      fare: json['fare'],
      waypoints: json['waypoints'],
      label: json['label'],
    );
  }
}
