import 'package:daladala_application_1/model_bus_stop_names_location.dart';

class Geometry {
  final myLocation location;

  Geometry({required this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = myLocation.fromJson(parsedJson['location']);
}
