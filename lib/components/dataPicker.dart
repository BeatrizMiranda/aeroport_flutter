import 'package:airport/components/button.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  _DatePicker createState() => _DatePicker();
}
class _DatePicker extends State<DatePicker> {

  var _chosedData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
    );
  }

  Widget _body() { 
    return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
            child: Image.asset(
              "src/img/SearchImg.png",
              fit: BoxFit.cover,
              height: 650
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _card(),
              ],
            ),
          ),
        ]
      );
  }

  Widget _card() { 
    return Card(
      margin: EdgeInsets.fromLTRB(15, 20, 20, 20),
      elevation: 10,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context, _chosedData.text),
                  icon: Icon(Icons.close, size: 30)
                ),
              ),
              Text("Selecione sua data", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: TextField(
                  controller: _chosedData,
                  decoration: InputDecoration(
                    labelText: "Escolha a data",
                    labelStyle: TextStyle(
                      color: Palette.lightBlack
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 22),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: 50, bottom: 90),
                child: CustomButton(
                  height: 60, 
                  text: "Salvar", 
                  onClick: () => Navigator.pop(context, _chosedData)
                ),
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}