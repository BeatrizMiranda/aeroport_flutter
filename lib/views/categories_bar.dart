import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _category(Icons.beach_access, Colors.blueAccent, Colors.white),
          _category(Icons.find_replace, Colors.greenAccent, Colors.white),
          _category(Icons.airport_shuttle, Colors.pink, Colors.white),
          _category(Icons.airplanemode_active, Colors.amber, Colors.white),
        ],
      ),
    );
  }

  Widget _category(icon, bgColor, iColor) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: bgColor,
      ),
      child: Icon(icon, color: iColor, size: 50,),
    );
  }

}

