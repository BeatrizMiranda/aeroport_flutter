import 'package:airport/components/button.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class PassangersPicker extends StatefulWidget {
  _PassangersPicker createState() => _PassangersPicker();
}
class _PassangersPicker extends State<PassangersPicker> {

  var _adultsController = TextEditingController();
  var _childController = TextEditingController();

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
      margin: EdgeInsets.fromLTRB(15, 10, 20, 20),
      elevation: 10,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context, {
                    "Adult": _adultsController.text, 
                    "Child": _childController.text
                  }),
                  icon: Icon(Icons.close, size: 30)
                ),
              ),
              Text("Opções de Voo", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: TextField(
                  controller: _adultsController,
                  decoration: InputDecoration(
                    labelText: "Adultos",
                    labelStyle: TextStyle(
                      color: Palette.lightBlack
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 22),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: TextField(
                  controller: _childController,
                  decoration: InputDecoration(
                    labelText: "Crianças",
                    labelStyle: TextStyle(
                      color: Palette.lightBlack
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 22),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 90),
                child: CustomButton(
                  height: 60, 
                  text: "Salvar", 
                  onClick: () => Navigator.pop(context, {
                    "Adult": _adultsController.text, 
                    "Child": _childController.text
                  })
                ),
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}