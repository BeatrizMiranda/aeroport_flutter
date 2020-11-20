import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/home.dart';
import 'package:airport/views/initialScreen.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

void main() {
  bool isLoged = false;

  runApp(MaterialApp(
    title: 'Time To Travel',
    theme: ThemeData(
      hintColor: Palette.lightOrange,
      primaryColor: Colors.white,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => isLoged ? Home() : InitialScreen(),
      '/home': (context) => Home(),
      '/search': (context) => SearchPage(),
      '/viagens': (context) => MyTrips(),
    },
  ));
}
