import 'package:airport/views/home.dart';
import 'package:airport/views/initialScreen.dart';
import 'package:flutter/material.dart';

void main() {
  bool isLoged = false;

  runApp(MaterialApp(
    title: 'Time To Travel',
    home: isLoged ? Home() : InitialScreen(),
    theme: ThemeData(
      hintColor: Color(0xFFFFA251),
      primaryColor: Colors.white,
    ),
  ));
}

