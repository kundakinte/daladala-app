import 'package:daladala_application_1/model_route_info.dart';

class getLegs {
  //final String distance;
  //final String duration;
  final myLegs leg;

  getLegs({required this.leg});

  factory getLegs.fromJson(Map<String, dynamic> json) {
    /*
    
    final data = Map<String, dynamic>.from(map['routes'][0]);
    String dis = '';
    String dur = '';
    final leg = data['legs'][0];
    dis = leg['distance']['text'];
    dur = leg['duration_in_traffic']['text'];
*/
    return getLegs(leg: myLegs.fromJson(json['legs'][0]));
  }
}
