import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:formainz/restin/widgets/common_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _borderRadius = 24;

  var items = [
    PlaceInfo('DOUBLE ESPRESSO (DOPPIO)', Color(0xff73A1F9), Color(0xff73A1F9),
        4, 'Frankfurt', 'Cosy · Casual · Good for kids'),
    PlaceInfo('FRAPPÉ', Color(0xff73A1F9), Color(0xff73A1F9), 2, 'Sharjah',
        'All you can eat · Casual · Groups'),
    PlaceInfo('ICED MOCHA', Color(0xff73A1F9), Color(0xff73A1F9), 1,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('LATTE MACCHIATO', Color(0xff73A1F9), Color(0xff73A1F9), 3,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('CAPPUCCINO', Color(0xff73A1F9), Color(0xff73A1F9), 5,
        'Dubai · In BurJuman', '...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(7.0), //kutular arası geçiş
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        items[index].startColor,
                        items[index].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: items[index].endColor,
                          blurRadius: 10,
                          offset: Offset(1, 4),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: CustomPaint(
                      size: Size(100, 150),
                      painter: CustomCardShapePainter(_borderRadius,
                          items[index].startColor, items[index].endColor),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/025-frappe.png',
                            height: 90,
                            width: 90,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index].name,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white, //kahve adları kısmı
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height:
                                    15, //kahve isimlerini yukarı kaydırıryor
                              ),
                              RatingBar(
                                rating: items[index].rating,
                              ),
                              /*
                              Text(
                                items[index].category,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              */

                              /*
                              Row(
                                children: <Widget>[
                                  
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black87,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Flexible(
                                    child: Text(
                                      items[index].location,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              */
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /*Text(  //puanlandırma
                                items[index].rating.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900),
                              ),
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final int rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
