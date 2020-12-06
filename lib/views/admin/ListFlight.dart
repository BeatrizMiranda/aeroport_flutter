import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:flutter/material.dart';

class ListFlight extends StatefulWidget {
  ListFlight({Key key}) : super(key: key);

  @override
  _ListFlightState createState() => _ListFlightState();
}
class _ListFlightState extends State<ListFlight> {
  TextEditingController flightNameController;

  void _flightNameChange(String text) {
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Center(child: 
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  "Voos", 
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)
                ),
              )
            ),
            Column(
              children: [
                Container (
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () { Navigator.pushNamed(context, "/new-flight"); },
                    child: Text(
                      "Cadastre um novo voo", 
                      style: TextStyle(fontSize: 20, color: Palette.darkOrange, decoration: TextDecoration.underline))
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: TextField(
                    controller: flightNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Encontre um voo",
                      hintStyle: TextStyle(color: Palette.lightBlack),
                      prefixIcon: Icon(Icons.search, color: Palette.lightBlack),
                    ),
                    style: TextStyle(fontSize: 22),
                    onChanged: _flightNameChange,
                  ),
                ),
                TripCard(
                  userFlight: FlightInfo(
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
                  isAdmin: true, 
                  handleClick: () {}
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}