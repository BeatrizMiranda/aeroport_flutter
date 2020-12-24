import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key, this.dropdownList, this.icon, this.placeholder}) : super(key: key);

  final List<String> dropdownList;
  final IconData icon;
  final String placeholder;

  @override
  _DropDown createState() => _DropDown();
}

class _DropDown extends State<DropDown> {
  String dropdownValue = '';

  void changeValue (String newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownList = widget.dropdownList;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5, right: 10),
          child: Icon(widget.icon),
        ),
        DropdownButton<String>(
          hint: Text(widget.placeholder, style: TextStyle(fontSize: 22, color: Palette.lightBlack),),
          value: dropdownValue.isEmpty ? null : dropdownValue,
          iconSize: 0,
          style: TextStyle(fontSize: 22, color: Palette.lightBlack),
          underline: Container(
            height: 0,
          ),
          onChanged: changeValue,
          items: dropdownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}