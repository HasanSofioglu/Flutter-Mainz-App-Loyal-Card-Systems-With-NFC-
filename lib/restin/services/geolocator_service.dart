import 'package:geolocator/geolocator.dart';

class GeolocatorSerice {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
