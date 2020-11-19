import 'package:airport/components/footer.dart';
import 'package:airport/components/homeFlightSugestions.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: Footer(),
      floatingActionButton: FooterFloatingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Palette.background,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
            child: Image.asset(
              "src/img/homeImg.png",
              fit: BoxFit.cover,
              height: 230
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Onde vamos agora?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage())),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.search, size: 35),
                        ),
                        Text("Encontre um voo", style: TextStyle(fontSize: 22, color: Palette.lightBlack)),
                      ],
                    ),
                  ),
                ),
                HomeFlightSugestions(),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

   
    
      
  
}
