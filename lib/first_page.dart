//import 'package:daladala_application_1/location.dart';
//import 'dart:html';

//import 'package:daladala_application_1/search.dart';
import 'dart:async';
import 'package:daladala_application_1/search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daladala_application_1/model_bus_stop_names.dart';
import 'package:daladala_application_1/apiconsume.dart';
import 'package:daladala_application_1/geo_loc.dart';
import 'package:daladala_application_1/change_notif.dart';
import 'package:daladala_application_1/model_place.dart';

int x = 0;
int y = 0;

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

//TextEditingController location = TextEditingController();
//TextEditingController destination = TextEditingController();

//late Future<List<Locations>> futureLocations = DMApi(loc, des);
//String loc = location.text;
//String des = destination.text;
//TextEditingController locat = TextEditingController();
//TextEditingController des = TextEditingController();
const Gapikey = "AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw";

class GoogleMapp extends StatefulWidget {
  const GoogleMapp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<GoogleMapp> {
  Completer<GoogleMapController> _cGM = Completer();
  late GoogleMapController mapController;

  late Position currentPos;
  var geolocator = Geolocator();

  /* @override
  void initState() {
    super.initState();
    futureLocations = DMApi();
  }*/

  //final locatorService = GeolocatorService();
  final LatLng _center = const LatLng(-6.776012, 39.178326);

  getlocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPos = position;
    LatLng llp = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: llp, zoom: 10);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // final loc = getlocation();

  void _onMapCreated(GoogleMapController controller) {
    _cGM.complete(controller);
    mapController = controller;
    getlocation();
  }

  @override
  void initState() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);
    appBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    /* final currentPos =
        Provider.of<Position>(context); //context.watch<Position>();
*/

    return /* ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: Consumer<AppState>(
            builder: (context, provider, child) => appState.initialPosition ==
                    null
                ? Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitRotatingCircle(
                            color: Colors.black,
                            size: 50.0,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: appState.locationServiceActive == false,
                        child: const Text(
                          "Please enable location services!",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      )
                    ],
                  ))
                /* FutureProvider(
        create: (context) => locatorService.determinePosition(),
        initialData: const Center(child: CircularProgressIndicator()),
        child:*/
                :*/
        MaterialApp(
            home: /*(appBloc.currentLocation == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : */
                Scaffold(
                    resizeToAvoidBottomInset: false,
                    /*appBar: AppBar(
                      iconTheme: const IconThemeData(color: Colors.black),
                      title: const Text(
                        'Enter Route',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      /*leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),*/
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(80.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 21.5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.gps_fixed),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          color: Colors.grey[200],
                                        ),
                                        child: TextField(
                                          onChanged: (value) =>
                                              appBloc.searchPlaces(value),
                                          controller: location,
                                          decoration: InputDecoration.collapsed(
                                              hintText: 'My Location',
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 9.0,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.place_sharp),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          color: Colors.grey[200],
                                        ),
                                        child: TextField(
                                          //onTap:
                                          onChanged: (value) =>
                                              appBloc.searchPlaces(value),

                                          controller: destination,
                                          textInputAction: TextInputAction.go,
                                          decoration: InputDecoration.collapsed(
                                              hintText: 'Destination',
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          appBloc.sendDirectionsApiRequest(
                                              location.text, destination.text);
                                          // DMApi(loc, des);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RouteMap()),
                                          );
                                        },
                                        child: Text("go"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 9.0,
                                )
                              ],
                            ),
                          )),
                    ),*/
                    body: /*(getlocation() != null)
              ? */
                        Stack(
                      // fit: StackFit.expand,
                      children: [
                        GoogleMap(
                          markers: appBloc.markers,
                          polylines: appBloc.polyLines,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          myLocationEnabled: true,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                /*appBloc.currentLocation!*/ _center.latitude,
                                /*appBloc.currentLocation!*/ _center.longitude),
                            zoom: 14.0,
                          ),
                        ),
                        if (x == 0)
                          Positioned(
                              top: 50,
                              left: 100,
                              right: 100,
                              child: ElevatedButton.icon(
                                  icon: Icon(Icons.search),
                                  label: Text(
                                    'Search/Tafuta....',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 40),
                                    primary: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20)),
                                  ))),
                        /*
                        if (appBloc.searchResults != null &&
                            appBloc.searchResults.length != 0)
                          Container(
                              //height: 300.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.6),
                                  backgroundBlendMode: BlendMode.darken)),
                        if (appBloc.searchResults != null)
                          Container(
                            //height: 300.0,
                            child: ListView.builder(
                                itemCount: appBloc.searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      appBloc.searchResults[index].description,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      //location.selection = true;
                                      location.text = appBloc
                                          .searchResults[index].description;
                                      destination.text = appBloc
                                          .searchResults[index].description;
                                      appBloc.setSelectedLocation(
                                          appBloc.searchResults[index].placeId);
                                    },
                                  );
                                }),
                          ),*/
                      ],
                    )));
  }
}

class RouteMap extends StatefulWidget {
  const RouteMap({Key? key}) : super(key: key);

  @override
  _RouteMapState createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-6.776012, 39.178326);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);
    appBloc.dispose();
    super.dispose();
  }

/*  @override
  void initState() {
    super.initState();
    busStops = Loc();
  }*/

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return MaterialApp(
      home: Scaffold(
          /* appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),*/
          body: Column(children: [
        Flexible(
            flex: 4,
            child: Stack(children: [
              GoogleMapp(),
              /*GoogleMap(
                compassEnabled: true,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),*/
              Positioned(
                  top: 20,
                  left: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        x = x - y;
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, shape: CircleBorder())))
            ])),
        Flexible(
            flex: 1,
            child:
                /*FutureBuilder<List<Locations>>(
          future: busStops,
          builder: (context, snapshot),
          {
    if (snapshot.hasData) {
      final locs = snapshot.data; 
      return buildLoc(locs);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },

        )*/
                Column(
                    /*
              children: [
                Text('DalaDala information',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      'Starting Bus Stop/Kutoka',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(' - Sayansi')
                  ],
                ),
                /*SizedBox(
                  height: 5.0,
                ),*/
                Row(children: [
                  Text(
                    'Destination Bus Stop/Kwenda',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(' - Victoria')
                ]),
                /*SizedBox(
                  height: 5.0,
                ),*/
                Row(children: [
                  Text(
                    'Route/Njia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(' - Sayansi -> Makumbusho -> Victoria')
                ]),
                /* SizedBox(
                  height: 5.0,
                ),*/
                Row(
                  children: [
                    Text(
                      'Bus',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        ' - Tegeta Nyuki to Kariakoo via Ally Hassan Mwinyi Road')
                  ],
                ),
                /*SizedBox(
                  height: 5.0,
                ),*/
                Row(
                  children: [
                    Text(
                      'Fare/Nauli',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(' - 500')
                  ],
                ),
                Row(
                  children: [
                    Text('Distance ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('- 2 km')
                  ],
                ),
                Row(
                  children: [
                    Text('Duration ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('- 5 mins')
                  ],
                ),
              ],*/
                    /*
                  children: [
                    ListView.builder(
                  itemCount: appBloc.mylegs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        appBloc.searchResults[index].description,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        //location.selection = true;
                        appBloc.location.text =
                            appBloc.searchResults[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults[index].placeId);
                      },
                    );
                  }),
                  ],
                    /*
              children: [
                FutureBuilder<List<Locations>>(
                    future: futureLocations,
                    builder: (context, snapshot) {
                      final locations = snapshot.data;
                      if (snapshot.hasData) {
                        return buildLoc(locations!);
                      } else if (snapshot.hasError) {
                        return Text('Error');
                      }
                      return const CircularProgressIndicator();
                    })
              ],
            */
                    */
                    ))
      ])),
    );
  }

  /* Widget buildLoc(List<Locations> locations) => ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final locss = locations[index];
          return Card(
            child: ListTile(
              title: Text(locss.route),
            ),
          );
        },
      );*/
}
