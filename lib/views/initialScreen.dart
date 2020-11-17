import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Color(0xFFF2F2F2),
    );
  }

  Widget _body() {
    return 
      Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
            child: Image.asset(
              "src/img/InitialScreen.png",
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
          )            
        ]
      );
  }

  Widget _card() {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Text(
                  "Para onde você quer ir?", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: _callToActionButton()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _callToActionButton() {
    return RaisedButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFFFA251), Color(0xFFFFB162)]),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 330.0, minHeight: 70.0),
          alignment: Alignment.center,
          child: Text(
            "Agende sua viagem",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
