import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:flutter/material.dart';
import 'package:airport/globals/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';


class ListFlight extends StatefulWidget {
  ListFlight({Key key}) : super(key: key);

  @override
  _ListFlightState createState() => _ListFlightState();
}

Future<List<FlightInfo>> getFlights(BuildContext context) async {


  var response = await http.get(globals.flightApi);

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    List<FlightInfo> voos = list.map((model) => FlightInfo.fromJson(model)).toList();

    return voos;
  } else {
    
    showFailMessage(context, 'Não foi possivel listar os voos, ${response.body}');
    throw Exception('Failed ${response.body}');
  }
}

class _ListFlightState extends State<ListFlight> {
  TextEditingController flightNameController = TextEditingController();

  List<FlightInfo> voos = [];
  void _flightNameChange(String text) {}

  @override
  void initState() {
    super.initState();

    getFlightsRequest();
  }

  void getFlightsRequest() async {
    List<FlightInfo> newflights = await getFlights(context);
    setState(() {
      voos = newflights;
    });
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
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Text("Voos",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Palette.lightBlack)),
            )),
            Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/new-flight");
                    },
                    child: Text("Cadastre um novo voo",
                        style: TextStyle(
                            fontSize: 20,
                            color: Palette.darkOrange,
                            decoration: TextDecoration.underline))),
              ),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              //   child: TextField(
              //     controller: flightNameController,
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.white,
              //       hintText: "Encontre um voo",
              //       hintStyle: TextStyle(color: Palette.lightBlack),
              //       prefixIcon: Icon(Icons.search, color: Palette.lightBlack),
              //     ),
              //     style: TextStyle(fontSize: 22),
              //     onChanged: _flightNameChange,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: Column(
                  children: List.generate(voos.length, (index) {
                    return TripCard(
                        userFlight: voos[index],
                        handleClick: () {},
                        isAdmin: globals.isAdmin);
                  }),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
