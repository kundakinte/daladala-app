import 'package:daladala_application_1/model_getlegs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:daladala_application_1/model_bernards_api.dart';
import 'package:provider/provider.dart';
import 'package:daladala_application_1/change_notif.dart';
import 'package:daladala_application_1/model_route_info.dart';

//final appBloc = Provider.of<AppBloc>(context);
class DirectionsApi {
  final key = 'AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw';
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2,
      {Position? uloc}) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];

    //    createRoute(route);
  }

  Future<getLegs> getRouteInfo(LatLng l1, LatLng l2, {Position? uloc}) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    //Map values = jsonDecode(response.body);
    var json = jsonDecode(response.body);
    var jsonResult = json['routes'][0] as Map<String, dynamic>;
    //var jsonResults = json['routes'][0] as List;
    //return values["routes"][0]["legs"][0]["distance"]["text"];

    return getLegs.fromJson(jsonResult);
    //return myLegs.fromJson(jsonResult);
    //return values["routes"][0]["legs"];
  }

  Future<String> getDuration(LatLng l1, LatLng l2, {Position? uloc}) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$key";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["legs"][0]["duration_in_traffic"]["text"];

    //    createRoute(route);
  }
}
