import 'package:flutter/material.dart';

class PrimaryTitleBar extends StatelessWidget {

  String _titleToShow;

  PrimaryTitleBar(this._titleToShow);

  @override
  Widget build(BuildContext context) {
    return Text(
      _titleToShow,
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }

}

