import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:daladala_application_1/model_your_location.dart';
import 'dart:convert' as convert;

class YourLocationService {
  final key = 'AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw';

  Future<List<YourLocation>> getYourLocation(Position yl) async {
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${yl.latitude},${yl.longitude}&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((yloc) => YourLocation.fromJson(yloc)).toList();
  }
}
