import 'package:daladala_application_1/model_bus_stop_names.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NameOfBusStops {
  final key = 'AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw';

  Future<List<BusStopName>> getLocBusStop(LatLng l) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?rankby=distance&location=${l.latitude},${l.longitude}&type=transit_station&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    //var jsonResult = json['results'] as Map<String, dynamic>;
    var jsonResults = json['results'] as List;
    return jsonResults
        .map((busStopN) => BusStopName.fromJson(busStopN))
        .toList();
    //return BusStopName.fromJson(jsonResult[0]);
  }

  Future<List<BusStopName>> getDesBusStop(LatLng d) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?rankby=distance&location=${d.latitude},${d.longitude}&type=transit_station&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults
        .map((busStopN) => BusStopName.fromJson(busStopN))
        .toList();
    //var jsonResult = json['results'] as Map<String, dynamic>;
    //return BusStopName.fromJson(jsonResult[0]);
  }
}
