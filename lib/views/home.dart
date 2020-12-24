import 'package:airport/components/footer.dart';
import 'package:airport/components/homeFlightCard.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

class FlightSuggestion {
  const FlightSuggestion({this.title, this.img});

  final String title;
  final String img;
}

const List<FlightSuggestion> flightSuggestion = const <FlightSuggestion>[
  const FlightSuggestion(title: "Dublin – Irlanda", img: "https://cdn.pixabay.com/photo/2013/12/18/18/01/bridge-230311_1280.jpg"),
  const FlightSuggestion(title: 'Tanzânia – África', img: "https://cdn.pixabay.com/photo/2014/03/02/18/05/tanzania-278367_960_720.jpg"),
  const FlightSuggestion(title: 'Huaraz - Peru', img: "https://cdn.pixabay.com/photo/2017/08/14/05/49/landscape-2639472_960_720.jpg"),
  const FlightSuggestion(title: 'Sardenha - Itália', img: "https://cdn.pixabay.com/photo/2018/07/09/21/05/sardinia-3527270_960_720.jpg"),
  const FlightSuggestion(title: 'Alberta - Canadá', img: "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204_960_720.jpg"),
  const FlightSuggestion(title: 'Tokyo - Japão', img: "https://cdn.pixabay.com/photo/2015/06/29/04/41/tokyo-tower-825196_960_720.jpg"),
];

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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                alignment: Alignment.topLeft,
                child: Text("Onde vamos agora?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
              _findFight(),
              Container(
                padding: EdgeInsets.only(bottom: 25),
                child: Text(
                  "Descubra Sua Próxima Aventura!", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Palette.lightBlack)
                ),
              ),
            ],
          ),
        ),
        
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HomeFlightCard(flightSuggestion: flightSuggestion[index]);
              },
              childCount: flightSuggestion.length,
            ), 
          ),
        )
      ],
    );
  }

  Widget _findFight() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
        ],
      ),
    );
  }
}