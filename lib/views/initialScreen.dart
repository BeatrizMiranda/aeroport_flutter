import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {

  InitialScreen({Key key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
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
                  child: CustomButton(
                    text : "Agende sua viagem!",
                    onClick: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage())),
                    height: 70,
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
