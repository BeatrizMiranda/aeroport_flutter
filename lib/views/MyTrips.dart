import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

class FlightInfo {
  const FlightInfo({
    this.destination, 
    this.shipment, 
    this.ship_date, 
    this.ship_time, 
    this.estimated_time, 
    this.limit, 
    this.airline_id, 
    this.status, 
    this.image 
  });

  final int limit;
  final int airline_id;
  final String image;
  final String status;
  final String shipment;
  final String ship_date;
  final String ship_time;
  final String destination;
  final String estimated_time;
}

const List<FlightInfo> userFlights = const <FlightInfo>[
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
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
];

class MyTrips extends StatefulWidget {
  MyTrips({Key key}) : super(key: key);

  @override
  _MyTripsState createState() => _MyTripsState();
}
class _MyTripsState extends State<MyTrips> {

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
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 80, 25, 20),
        child: 
          Column( children: [
            Center(child: Text("Minhas Viagens", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack))),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: userFlights.length > 0 ? _listOfTrips() : _emptyTrips() 
            ),
          ],
        ),
      )
    );
  }

  Widget _emptyTrips() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Text('Você não possui viagens', style: TextStyle(fontSize: 22, color: Palette.lightBlack)),
          ),
          Image.asset(
            "src/img/EmptyTrips.png",
            fit: BoxFit.cover,
            height: 250
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: InkWell(
              child: Text('Agende Uma!', style: TextStyle(decoration: TextDecoration.underline, fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightText)),
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage())),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _listOfTrips() {
    
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(
        children: 
          List.generate(userFlights.length, (index) {
            return TripCard(userFlight: userFlights[index], isAdmin: false);
          }),
      ),
    );
  }

}
