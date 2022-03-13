import 'package:flutter/material.dart';
import 'package:formainz/mainlist/login_sign/Signup.dart';
import 'package:formainz/mainlist/login_sign/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  TextEditingController locationController = TextEditingController();
  LatLng currentLocation = LatLng(-2.142869, -79.923845);
  GoogleMapController _mapController;
  bool buscando = false;
  String header = "";
  String city = "";
  String postCode = "";

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  void getMoveCamera() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    locationController.text = placemark[0].street;
    setState(() {
      header = placemark[0].street;
      city = placemark[0].country;
      postCode = placemark[0].postalCode;
    });
  }

  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    currentLocation = LatLng(position.latitude, position.longitude);
    locationController.text = placemark[0].country;
    _mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      buscando = false;
      currentLocation = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: currentLocation, zoom: 40),
            minMaxZoomPreference: MinMaxZoomPreference(10.5, 16.8),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onCameraMove: onCameraMove,
            onMapCreated: onCreated,
            onCameraIdle: () async {
              buscando = true;
              setState(() {
                getMoveCamera();
              });
              //texte adresin geldiği yer
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/marker.png",
              height: 80,
            ),
          ),
          buscando == true
              ? Positioned(
                  top: MediaQuery.of(context).size.height / 3.05,
                  left: MediaQuery.of(context).size.height / 7.50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.black.withOpacity(0.75),
                    ),
                    width: 195,
                    height: 50,
                    child: Center(
                      child: Text(
                        "$header",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ))
              : Positioned(
                  top: MediaQuery.of(context).size.height / 3.45,
                  left: MediaQuery.of(context).size.width / 2.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.black.withOpacity(0.75)),
                    width: 50,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2.5,
                      ),
                    ),
                  ),
                ),
          Positioned(
            top: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: getUserLocation,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.gps_fixed,
                color: Colors.blueAccent,
                size: 32,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width / 40,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  )),
              height: MediaQuery.of(context).size.height / 2.86,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: TextField(
                        enabled: false,
                        controller: locationController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.map_outlined),
                        ),
                      ),
                    ),
                    Container(
                      height: 38,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.panorama_horizontal_select_rounded),
                            hintText: postCode,
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 14.5,
                            )),
                      ),
                    ),
                    Container(
                      height: 38,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.location_city),
                            hintText: city,
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 14.5,
                            )),
                      ),
                    ),
                    //container
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Save My Location",
                          style: TextStyle(fontSize: 17.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context,
                              '$header' + ' ' + '$city' + ' ' + '$postCode');
                        },
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget appBar() {
    return AppBar(
      actionsIconTheme: IconThemeData(color: Colors.blueAccent),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        color: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [],
    );
  }
}
