import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocatorService {
  Future<Position> getlocation() async {
    LatLng _center = const LatLng(-6.776012, 39.178326);
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    /*if (permission == LocationPermission.unableToDetermine ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Position p = _center as Position;
      return p;
    }*/
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
