import 'package:http/http.dart' as http;
import 'dart:convert';

DMApi(String l, String d) async {
  var response = await http.get(Uri.parse(
      'https://daladalaapi.vercel.app/route/api?currentLocation=$l&destination=$d'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    //print(data);
  } else {
    throw Exception("failed");
  }
}
