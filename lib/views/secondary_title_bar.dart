import 'package:flutter/material.dart';

class SecondaryTitleBar extends StatelessWidget {

  String _titleToShow;

  SecondaryTitleBar(this._titleToShow);

  @override
  Widget build(BuildContext context) {
    return Text(
      _titleToShow,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }
}