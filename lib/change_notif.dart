import 'dart:async';
//import 'dart:math';
import 'package:daladala_application_1/model_bus_stop_names.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daladala_application_1/model_bernards_api.dart';
import 'package:daladala_application_1/service_bus_stop_names.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:daladala_application_1/geo_loc.dart';
import 'package:daladala_application_1/service_places.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:daladala_application_1/model_bus_stop_names_geometry.dart';
import 'package:daladala_application_1/model_bus_stop_names_location.dart';
import 'package:daladala_application_1/model_place.dart';
import 'package:daladala_application_1/model_place_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daladala_application_1/directions_api.dart';
import 'package:daladala_application_1/first_page.dart';
import 'package:daladala_application_1/model_route_info.dart';
import 'package:daladala_application_1/model_getlegs.dart';
import 'package:daladala_application_1/model_your_location.dart';
import 'package:daladala_application_1/service_your_location.dart';

class AppBloc with ChangeNotifier {
  //static LatLng _initialposition;
  //LatLng _lastPosition = _initialposition;
  late String dur;
  List<YourLocation> ylocs = [];
  YourLocationService yourLocationService = YourLocationService();
  Completer<GoogleMapController> _cGM = Completer();
  late GoogleMapController mapController;
  late getLegs mylegs;
  bool locservactive = true;
  TextEditingController location = TextEditingController();
  TextEditingController destination = TextEditingController();
  NameOfBusStops nameOfBusStops = NameOfBusStops();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  final geolocatorservice = GeolocatorService();
  DirectionsApi directionsApi = DirectionsApi();
  Position? currentLocation;
  final placesService = PlacesService();
  List<PlaceSearch> searchResults = [];
  List<PlaceSearch> searchResults1 = [];
  List<Place> placeResults = [];
  late Place selectedLocationStatic;
  StreamController<Place> selectedLocation = StreamController<Place>();
  Set<Polyline> get polyLines => _polyLines;
  Set<Marker> get markers => _markers;

  AppBloc() {
    setCurrentLocation();
  }
  //getRouteInfo() async {}

  final key = 'AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw';
  Future<String> getRouteCoordinates(
      List<BusStopName> bsn /*LatLng l1, LatLng l2*/) async {
    var v;
    for (int i = 0; i < 1; i++) {
      String url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${bsn[i].name}&destination=${bsn[i + 1].name}&key=$key";
      http.Response response = await http.get(Uri.parse(url));
      Map values = jsonDecode(response.body);
      v = values;
      // createRoute(route);
    }
    return v["routes"][0]["overview_polyline"]["points"];
    notifyListeners();
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(currentLocation.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _cGM.complete(controller);
    mapController = controller;
    notifyListeners();
  }

  void sendDirectionsApiRequest(String locContr, String desContr,
      {Position? userloc}) async {
    List<Location> location1 = await locationFromAddress(locContr);
    List<Location> location2 = await locationFromAddress(desContr);
    LatLng l1 = LatLng(location1[0].latitude, location1[0].longitude);
    LatLng l2 = LatLng(location2[0].latitude, location2[0].longitude);

    List<BusStopName> locBusStop = await nameOfBusStops.getLocBusStop(l1);
    List<BusStopName> desBusStop = await nameOfBusStops.getDesBusStop(l2);
    LatLng busloc1 = LatLng(locBusStop[0].geometry.location.lat,
        locBusStop[0].geometry.location.lng);
    LatLng busloc2 = LatLng(desBusStop[0].geometry.location.lat,
        desBusStop[0].geometry.location.lng);
    _addMarker(l1, locContr, l2, desContr, locBusStop[0].name, busloc1,
        desBusStop[0].name, busloc2);

    print(locBusStop[0].name);
    print(desBusStop[0].name);
    DMApi(locBusStop[0].name, desBusStop[0].name);
    String route = await directionsApi.getRouteCoordinates(l1, l2);
    createRoute(route);
    dur = await directionsApi.getDuration(l1, l2);
    print(dur);
    mylegs = await directionsApi.getRouteInfo(l1, l2);
    //print(mylegs);
    print(mylegs.leg.distance);
    //print(mylegs.leg.duration);
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  searchPlaces1(String searchTerm1) async {
    searchResults1 = await placesService.getAutocomplete(searchTerm1);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    sLocation.geometry.location.lat;
    selectedLocationStatic = sLocation;
    // searchResults = null;
    notifyListeners();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorservice.getlocation();
    //_initialPosition =LatLng(currentLocation!.latitude, currentLocation!.longitude);
    List<Placemark> placemark = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude,
        localeIdentifier: 'tz');
    //location.text = placemark[0].name!;
    print(placemark);
    ylocs = await yourLocationService.getYourLocation(currentLocation!);
    location.text = ylocs[0].formatted_address;
    LatLng llp = LatLng(currentLocation!.latitude, currentLocation!.longitude);
    CameraPosition cameraPosition = CameraPosition(target: llp, zoom: 10);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    /*selectedLocationStatic = Place(name: null,
      geometry: Geometry(location: Location(
          lat: currentLocation.latitude, lng: currentLocation.longitude),),);*/
    notifyListeners();
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void _addMarker(LatLng location, String address, LatLng location1,
      String address1, String bsn1, LatLng bsl1, String bsn2, LatLng bsl2) {
    _markers.add(Marker(
        markerId: MarkerId('starting location'),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "Starting location"),
        icon: BitmapDescriptor.defaultMarker));

    _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: location1,
        infoWindow: InfoWindow(title: address1, snippet: "Destination"),
        icon: BitmapDescriptor.defaultMarker));

    /*_markers.add(Marker(
        markerId: MarkerId('1st bus stop'),
        position: LatLng(-6.7729938, 39.2409040),
        infoWindow: InfoWindow(title: 'Sayansi', snippet: "First Bus Stop"),
        icon: BitmapDescriptor.defaultMarker));

    _markers.add(Marker(
        markerId: MarkerId('2nd bus stop'),
        position: LatLng(-6.7782764, 39.2524985),
        infoWindow:
            InfoWindow(title: 'Victoria', snippet: "Destination Bus Stop"),
        icon: BitmapDescriptor.defaultMarker));*/
    notifyListeners();
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  /* setCurrentLocation() async {
    currentLocation = await geolocatorservice.getlocation();
    notifyListeners();
  }*/
}
