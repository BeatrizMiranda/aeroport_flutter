import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.icon, this.label, this.controller, this.handleChange});

  final IconData icon;
  final String label;
  final TextEditingController controller;
  final Function handleChange;

  @override
  Widget build(BuildContext context) {  
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
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
        onChanged: handleChange,
      ),
    );
  }
}