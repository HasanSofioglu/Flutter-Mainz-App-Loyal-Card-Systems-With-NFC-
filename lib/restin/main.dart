import 'package:flutter/material.dart';
import 'package:formainz/restin/ui/generate_page.dart';
//import 'package:foody/ui/coffee_page.dart';

import 'package:provider/provider.dart';

import 'blocs/application_bloc.dart';

void main() => runApp(restinpage());

class restinpage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        home: GeneratePage(),
      ),
    );
  }
}
