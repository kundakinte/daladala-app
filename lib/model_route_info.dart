import 'package:daladala_application_1/model_duration.dart';
import 'package:daladala_application_1/model_distance.dart';

class myLegs {
  final myDistance distance;
  final myDuration duration;

  myLegs({required this.distance, required this.duration});

  factory myLegs.fromJson(Map<String, dynamic> parsedJson) {
    return myLegs(
        distance: myDistance.fromJson(parsedJson['distance']),
        duration: myDuration.fromJson(parsedJson['duration_in_traffic']));
  }
}
