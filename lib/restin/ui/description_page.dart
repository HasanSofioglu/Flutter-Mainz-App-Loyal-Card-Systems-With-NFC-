import 'package:flutter/material.dart';
import 'package:formainz/restin/blocs/application_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DetailPage(),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(160.0),
                  ),
                  Container(
                    height: 332.0,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              applicationBloc.currentLocation.latitude,
                              applicationBloc.currentLocation.longitude),
                          zoom: 14),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50),
                        Text(
                          'Coffee World',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 35,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),

                        /*
                        Text(
                          'About The Shop',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 25,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        */
                        Divider(
                          color: Colors.black38,
                        ),
                        SizedBox(height: 40),
                        Text(
                          'We are with you with our different types of coffee...',
                          style: TextStyle(
                            fontFamily: 'Avenir-Heavy',
                            fontSize: 20,
                            color: const Color(0xff868686),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 32),
                        Divider(color: Colors.black38),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _bottomShett(context);
                            },
                            //color: Colors.deepPurple,
                            //padding:EdgeInsets.all(10.0),

                            child: Text(
                              'Details',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_bottomShett(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext c) {
        return Wrap(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/pho.png',
                      height: 40.0,
                    ),
                    title: Text(
                      '021256323',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/loc.png',
                      height: 40.0,
                    ),
                    title: Text(
                      'Mainzer Landstrasse',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/mail.png',
                      height: 40.0,
                    ),
                    title: Text(
                      'example@gmail.com',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      });
}
