import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.text, this.onClick, this.height});

  final String text;
  final Function onClick;
  final double height;


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Palette.darkOrange, Palette.lightOrange]),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 330.0, minHeight: height),
          alignment: Alignment.center,
          child: Text(
            text, style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}