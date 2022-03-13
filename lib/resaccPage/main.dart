import 'package:flutter/material.dart';
import 'package:formainz/resaccPage/screens/home_screen.dart';

class RestAccpage extends StatefulWidget {
  String idRest;
  String typeSelect;
  RestAccpage({Key key, @required this.idRest, this.typeSelect})
      : super(key: key);
  @override
  _RestAccpage createState() => _RestAccpage(idRest, typeSelect);
}

class _RestAccpage extends State<RestAccpage> {
  String idRest;
  String typeSelect;

  _RestAccpage(this.idRest, String typeSelect);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            color: Colors.black87,
          ),
          headline2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: Colors.grey,
          ),
          headline4: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
          caption: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 13,
          ),
          button: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(userId: idRest,typeSelect: typeSelect,),
    );
  }
}
