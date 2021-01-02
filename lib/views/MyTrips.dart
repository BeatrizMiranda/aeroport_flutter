import 'package:airport/components/TicketCard.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:airport/globals/globals.dart' as globals;
import 'dart:convert';

class FlightInfo {
  const FlightInfo({
    this.id,
    this.destination,
    this.shipment,
    this.ship_date,
    this.ship_time,
    this.estimated_time,
    this.limit,
    this.airline_id,
    this.status,
    this.ticket_price,
    this.image
  });

  final int id;
  final int limit;
  final int airline_id;
  final String image;
  final String status;
  final String shipment;
  final String ship_date;
  final String ship_time;
  final String destination;
  final dynamic ticket_price;
  final String estimated_time;

  factory FlightInfo.fromJson(Map<String, dynamic> json) {
    return FlightInfo(
      id: json['id'],
      image: json['image'],
      destination: json['destination'],
      shipment: json['shipment'],
      ship_date: json['ship_date'],
      ship_time: json['ship_time'],
      estimated_time: json['estimated_time'],
      limit: json['limit'],
      airline_id: json['airline_id'],
      status: json['status'],
      ticket_price: json['ticket_price'],
    );
  }
}

class TicketInfo {
  const TicketInfo({
    this.id,
    this.destination,
    this.shipment,
    this.ship_date,
    this.ship_time,
    this.estimated_time,
    this.limit,
    this.airline_id,
    this.status,
    this.ticket_price,
    this.image,
    this.airline,
    this.airline_logo,
    this.amount_ticket,
    this.price_ticket,
    this.child_amount,
    this.total_paid,
    this.ticket_id,
  });

  final int ticket_id;
  final int id;
  final int limit;
  final int airline_id;
  final String image;
  final String status;
  final String shipment;
  final String ship_date;
  final String ship_time;
  final String destination;
  final dynamic ticket_price;
  final String estimated_time;
  final String airline;
  final String airline_logo;
  final int amount_ticket;
  final dynamic price_ticket;
  final int child_amount;
  final dynamic total_paid;

  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    return TicketInfo(
      ticket_id: json['ticket_id'],
      id: json['id'],
      destination: json['destination'],
      shipment: json['shipment'],
      ship_date: json['ship_date'],
      ship_time: json['ship_time'],
      estimated_time: json['estimated_time'],
      image: json['image'],
      limit: json['limit'],
      airline_id: json['airline_id'],
      status: json['status'],

      airline: json['airline'],
      airline_logo: json['airline_logo'],
      amount_ticket: json['amount_ticket'],
      price_ticket: json['price_ticket'],
      child_amount: json['child_amount'],
      total_paid: json['total_paid'],
    );
  }
}

Future<List<TicketInfo>> getUserTickets(BuildContext context) async {
  var response = await http.get(
    globals.getUserTickets,
    headers: <String, String>{
      'Authorization': 'bearer ${globals.token}',
    }
  );

  if (response.statusCode == 200) {
    print(response.body);
    Iterable list = json.decode(response.body);
    List<TicketInfo> voos = list.map((model) => TicketInfo.fromJson(model)).toList();
    
    return voos;
  } else {
    
    showFailMessage(context, 'Não foi possivel listar seus tickets, ${response.body}');
    throw Exception('Failed ${response.body}');
  }
}

class MyTrips extends StatefulWidget {
  MyTrips({ Key key }) : super(key: key);

  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  
  List<TicketInfo> userTickets = [];

  @override 
  void initState() {
    super.initState();
    getFlights();
  }

  void getFlights() async {
    List<TicketInfo> newTickets = await getUserTickets(context);
    
    setState(() {
      userTickets = newTickets;
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
      padding: const EdgeInsets.fromLTRB(25, 80, 25, 20),
      child: Column(
        children: [
          Center(
              child: Text("Minhas Viagens",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Palette.lightBlack))),
          Container(
              padding: EdgeInsets.only(top: 5),
              child: userTickets.length > 0 ? _listOfTrips() : _emptyTrips()),
        ],
      ),
    ));
  }

  Widget _emptyTrips() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Text('Você não possui viagens',
                style: TextStyle(fontSize: 22, color: Palette.lightBlack)),
          ),
          Image.asset("src/img/EmptyTrips.png", fit: BoxFit.cover, height: 250),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: InkWell(
              child: Text('Agende Uma!',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Palette.lightText)),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SearchPage())),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listOfTrips() {
    return Expanded(
        child: SizedBox(
          height: 630,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: userTickets.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return TicketCard(
                userFlight: userTickets[index],
                isAdmin: globals.isAdmin
              );
            },
          ),
        ),
      );
  }
}

