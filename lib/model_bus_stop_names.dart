import 'package:daladala_application_1/model_bus_stop_names_geometry.dart';

class BusStopName {
  final String name;
  final Geometry geometry;

  const BusStopName({
    required this.name,
    required this.geometry,
  });

  factory BusStopName.fromJson(Map<String, dynamic> json) => BusStopName(
        name: json['name'],
        geometry: Geometry.fromJson(json['geometry']),
      );
}
