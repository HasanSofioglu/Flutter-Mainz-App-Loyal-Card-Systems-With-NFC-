import 'package:flutter/cupertino.dart';
import 'package:formainz/restin/services/geolocator_service.dart';

import 'package:geolocator/geolocator.dart';

class ApplicationBloc with ChangeNotifier {
  final GeoLocatorService = GeolocatorSerice();

  Position currentLocation;

  ApplicationBloc() {
    setCurrentLocation();
  }
  setCurrentLocation() async {
    currentLocation = await GeoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}
