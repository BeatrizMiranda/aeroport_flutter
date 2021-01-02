import 'package:airport/components/BuyTicket.dart';
import 'package:airport/globals/globals.dart' as globals;
import 'package:airport/components/Cadastro.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/home.dart';
import 'package:airport/views/searchResult.dart';
import 'package:flutter/material.dart';

class FlightOfDestination extends StatefulWidget {
  FlightOfDestination({Key key, this.flightSuggestion}) : super(key: key);

  final FlightSuggestion flightSuggestion;

  @override
  _FlightOfDestinationState createState() => _FlightOfDestinationState();
}

class _FlightOfDestinationState extends State<FlightOfDestination> {

  List<FlightInfo> userFlights = [];

  @override 
  void initState() {
    super.initState();
    getFlights();
  }

  void getFlights() async {
    List<FlightInfo> newFlightList = await getFlightsList(
      widget.flightSuggestion.title, '', '', context
    );
    
    setState(() {
      userFlights = newFlightList;
    });
  }


  void handleBuy(FlightInfo flight) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Cadastro(goTo: '/viagens')));
    // depois do login faze a api de compra
  }

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
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Image.network(widget.flightSuggestion.img,
                    fit: BoxFit.fill),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                alignment: Alignment.topLeft,
                child: Text(widget.flightSuggestion.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
              _listOfFlights()
            ],
          ),
        ),
      ],
    );
  }

  Widget _listOfFlights() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: List.generate(userFlights.length, (index) {
          return TripCard(
              userFlight: userFlights[index],
              handleClick: 
                () async {
                await Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => 
                    BuyTicket(userFlight: userFlights[index])
                  )
                );
              },
              isAdmin: globals.isAdmin);
        }),
      ),
    );
  }
}
