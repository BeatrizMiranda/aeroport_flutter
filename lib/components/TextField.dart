import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key key, @required this.icon,  this.label,  this.controller, this.isPassword = false}) : super(key: key);

  final bool isPassword;
  final IconData icon;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {  
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}