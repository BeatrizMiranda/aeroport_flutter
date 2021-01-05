import 'package:airport/components/BuyTicket.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:airport/globals/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightSearch {
  const FlightSearch(
      { this.destination, this.shipment, this.ship_date, this.qtdAdults, this.qtdChilds });

  final String shipment;
  final String ship_date;
  final String destination;
  final int qtdAdults;
  final int qtdChilds;
}
class SearchResult extends StatefulWidget {
  SearchResult({Key key, this.flightsOptions}) : super(key: key);

  final FlightSearch flightsOptions;

  @override
  _SearchResultState createState() => _SearchResultState();
}

Future<List<FlightInfo>> getFlightsList(String destination, String shipement, String date, BuildContext context) async {
  var queryShip = shipement.isNotEmpty ? '&ship=${shipement}' : '';
  var queryDate = date.isNotEmpty ? '&date=${date}' : '';

  var query = '?dest=${destination}${queryShip}${queryDate}';

  var response = await http.get('${globals.flightApi}${query}');

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    List<FlightInfo> voos = list.map((model) => FlightInfo.fromJson(model)).toList();
    
    return voos;
  } else {
    
    showFailMessage(context, 'Não foi possivel listar os voos, ${response.body}');
    throw Exception('Failed ${response.body}');
  }
}

class _SearchResultState extends State<SearchResult> {

  int quantity;
  FlightSearch flightsOptions;
  List<FlightInfo> listOfFlights = [];

  @override 
  void initState() {
    super.initState();
    flightsOptions = widget.flightsOptions;
    quantity = widget.flightsOptions.qtdAdults + widget.flightsOptions.qtdChilds;
    getFlights();
  }

  void getFlights() async {
    List<FlightInfo> newFlightList = await getFlightsList(
      flightsOptions.destination,
      flightsOptions.shipment,
      flightsOptions.ship_date,
      context
    );
    
    setState(() {
      listOfFlights = newFlightList;
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
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Image.asset(
                  "src/img/searchOpacity.png",
                  fit: BoxFit.contain,
                  height: 220,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 55, 30, 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(flightsOptions.shipment,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            Image.asset("src/img/planeIcon.png",
                                fit: BoxFit.contain),
                            Text(flightsOptions.destination,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(flightsOptions.ship_date,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            Column(children: [
                              Text("$quantity Ticket(s)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                              Text("${flightsOptions.qtdAdults} Adulto(s) ${flightsOptions.qtdChilds > 0 ? '- ${flightsOptions.qtdChilds} Criança(s)': ''}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),

                            ],)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${listOfFlights.length} resultados encontrados",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        IconButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage())),
                          icon: Icon(Icons.settings,
                              color: Palette.lightBlack, size: 25),
                        ),
                      ],
                    ),
                    listOfFlights.length > 0 ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(listOfFlights.length, (index) {
                            return TripCard(
                              userFlight: listOfFlights[index],
                              isAdmin: globals.isAdmin,
                              handleClick:
                                 () async {
                                  await Navigator.push(context, 
                                    MaterialPageRoute(builder: (context) => 
                                      BuyTicket(
                                        userFlight: listOfFlights[index],
                                        qtdAdults: widget.flightsOptions.qtdAdults,
                                        qtdChilds: widget.flightsOptions.qtdChilds
                                      )
                                    )
                                  );
                                }
                              );
                          }) 
                        ),
                      )
                      : 
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Text("Não encontramos nenhum voo que atende os seus parâmetros",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text("Tente novamente",
                                style: TextStyle(fontSize: 20)
                              ),
                            ),
                        ],
                    ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
