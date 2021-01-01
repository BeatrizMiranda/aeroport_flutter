import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key key, 
    @required this.icon,  
    this.label,  
    this.controller, 
    this.isPassword = false, 
    this.fontSize = 22, 
    this.padding = 10, 
  }) : super(key: key);

  final bool isPassword;
  final IconData icon;
  final String label;
  final double fontSize;
  final double padding;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {  
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Palette.lightBlack
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
          ),
          prefixIcon: Icon(icon, color: Palette.lightBlack),
        ),
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}