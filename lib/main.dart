import 'package:daladala_application_1/geo_loc.dart';
import 'package:daladala_application_1/first_page.dart';
import 'package:flutter/material.dart';
import 'package:daladala_application_1/change_notif.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:provider/provider.dart';
//import 'package:daladala_application_1/location.dart';
import 'package:provider/provider.dart';
//import 'package:daladala_application_1/main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppBloc(),
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: GoogleMapp()));
  }
}

/*class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dala dala Information System'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const Text('Are you a?'),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GoogleMapp()),
                  );
                },
                child: const Text('A normal user')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BusReg()),
                  );
                },
                child: const Text('A bus'))
          ])),
    );
  }
}*/
