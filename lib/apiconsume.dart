/*import 'dart:convert';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart' as http;
import 'package:daladala_application_1/model_bus_stop_names.dart';
import 'package:daladala_application_1/search.dart';

/*class LocsApi {
  static Future<List<Locations>> getLoc(String query) async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List locs = json.decode(response.body);

      return locs.map((json) => Locations.fromJson.fromJson(json)).where((loc) {
        final titleLower = loc.title.toLowerCase();
        //final authorLower = loc.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}*/
class ApiConsume {
  Future<List<Locations>> Loc(String l, String d) async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Locations>(Locations.fromJson).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  DMApi() async {
    var response2 = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations={}&origins={}&units=metric&key=YOUR_API_KEY'));
    if (response2.statusCode == 200) {
      final data2 = jsonDecode(response2.body);
      return data2;
    } else {
      throw Exception("failed");
    }
  }

  DirectionsAPi() async {
    var response3 = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=Adelaide,SA&destination=Adelaide,SA'));
    if (response3.statusCode == 200) {
      final data3 = jsonDecode(response3.body);
      return data3;
    } else {
      throw Exception("failed");
    }
  }
}*/
