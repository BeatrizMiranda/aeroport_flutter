import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';


class FlightOfDestination extends StatefulWidget {
  FlightOfDestination({Key key, this.flightSuggestion }) : super(key: key);

  final FlightSuggestion flightSuggestion;

  @override
  _FlightOfDestinationState createState() => _FlightOfDestinationState();
}
class _FlightOfDestinationState extends State<FlightOfDestination> {

  ///TODO: get flight by destination

  List<FlightInfo> userFlights = <FlightInfo>[
    FlightInfo(
      destination: "São Paulo", 
      shipment: "Rio de Janeiro", 
      ship_date: "2020-07-02T03:00:00.000Z", 
      ship_time: "18:00:00", 
      estimated_time: "03:00:00", 
      limit:46, 
      airline_id: 1, 
      status: "ativo", 
      image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
    ),
    FlightInfo(
      destination: "Rio de Janeiro", 
      shipment: "São Paulo", 
      ship_date: "2020-07-02T03:00:00.000Z", 
      ship_time: "18:00:00", 
      estimated_time: "03:00:00", 
      limit:46, 
      airline_id: 1, 
      status: "ativo", 
      image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
    ),
    FlightInfo(
      destination: "Rio de Janeiro", 
      shipment: "São Paulo", 
      ship_date: "2020-07-02T03:00:00.000Z", 
      ship_time: "18:00:00", 
      estimated_time: "03:00:00", 
      limit:46, 
      airline_id: 1, 
      status: "ativo", 
      image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
    ),
    FlightInfo(
      destination: "Rio de Janeiro", 
      shipment: "São Paulo", 
      ship_date: "2020-07-02T03:00:00.000Z", 
      ship_time: "18:00:00", 
      estimated_time: "03:00:00", 
      limit:46, 
      airline_id: 1, 
      status: "ativo", 
      image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
    ),
    FlightInfo(
      destination: "Rio de Janeiro", 
      shipment: "São Paulo", 
      ship_date: "2020-07-02T03:00:00.000Z", 
      ship_time: "18:00:00", 
      estimated_time: "03:00:00", 
      limit:46, 
      airline_id: 1, 
      status: "ativo", 
      image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
    ),
  ];

  
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
                child: Image.network(
                  widget.flightSuggestion.img,
                  fit: BoxFit.fill
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                alignment: Alignment.topLeft,
                child: Text(widget.flightSuggestion.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: 
          List.generate(userFlights.length, (index) {
            return TripCard(userFlight: userFlights[index]);
          }),
      ),
    );
  }

}