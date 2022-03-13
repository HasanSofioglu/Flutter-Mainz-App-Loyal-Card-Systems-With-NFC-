import 'package:flutter/material.dart';
import 'package:formainz/restin/ui/coffee_page.dart';
import 'package:formainz/restin/ui/description_page.dart';
import 'package:tuple/tuple.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key key}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final List<Tuple2> _pages = [
    Tuple2('Coffee', HomePage()),
    Tuple2('Description', DetailPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor:
              Colors.white, //Changing this will change the color of the TabBar
          accentColor: Colors.cyan[600],
        ),
        home: DefaultTabController(
          length: _pages.length,
          child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Coffee',
                ),
                Tab(
                  text: 'Description',
                )
              ],
            )),
            body: TabBarView(
              children:
                  _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
            ),
          ),
        ));
  }
}
