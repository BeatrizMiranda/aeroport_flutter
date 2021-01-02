import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key, this.dropdownList, this.icon, this.placeholder, this.dropdownValue, this.handleChange}) : super(key: key);

  final List<String> dropdownList;
  final IconData icon;
  final String placeholder;
  final String dropdownValue;
  final Function handleChange;

  @override
  _DropDown createState() => _DropDown();
}

class _DropDown extends State<DropDown> {
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
          value: widget.dropdownValue.isEmpty ? null : widget.dropdownValue,
          iconSize: 0,
          style: TextStyle(fontSize: 22, color: Palette.lightBlack),
          underline: Container(
            height: 0,
          ),
          onChanged: (newValue) => widget.handleChange(newValue),
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