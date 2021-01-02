import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;

class TicketCard extends StatefulWidget {
  TicketCard({ Key key, this.userFlight, this.isAdmin }) : super(key: key);

  final TicketInfo userFlight;
  final bool isAdmin;

  @override
  _TicketCard createState() => _TicketCard();
}

void flightCancel(BuildContext context, int id) async {
  var response = await http.put(
    '${globals.cancelTicket}/$id', 
    headers: <String, String>{
      'Authorization': 'bearer ${globals.token}',
    }
  );

  if (response.statusCode == 200) {
    showSuccessMessage(context, 'Passagem cancelada com sucesso');
  } else {
    showFailMessage(context, 'Não foi possivel cancelar a passagem, ${response.body}');
    throw Exception('Failed ${response.body}');
  }
}

class _TicketCard extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {

    int amountAdults = widget.userFlight.amount_ticket - widget.userFlight.child_amount;
    String amountChilds = widget.userFlight.child_amount != 0 ? '${widget.userFlight.child_amount} criança(s)': '';

    void handleTripCancel() async {
      flightCancel(context, widget.userFlight.ticket_id);
    }

    DateTime estimatedHours = DateTime.parse("2020-01-01 ${widget.userFlight.estimated_time}");
    DateTime parseShipDate = DateTime.parse("2020-01-01 ${widget.userFlight.ship_time}");
    DateTime deliveryTime = parseShipDate.add(Duration(
      minutes: (estimatedHours.hour * 60) + estimatedHours.minute)
    );

    String deliveryTimeFormated = DateFormat.Hm().format(deliveryTime);
    String shipTimeFormated = DateFormat.Hm().format(parseShipDate);
    String estimatedHoursFormated = "${DateFormat('hh').format(estimatedHours)}h${DateFormat('mm').format(estimatedHours)}min de voo";

    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(bottom: 25),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.userFlight.shipment,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Image.asset("src/img/planeIcon.png", fit: BoxFit.contain),
                  Text(widget.userFlight.destination,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(shipTimeFormated,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$deliveryTimeFormated',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.userFlight.ship_date,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(estimatedHoursFormated,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.userFlight.amount_ticket} Tickets',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$amountAdults Adulto(s) $amountChilds',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.network(widget.userFlight.airline_logo, fit: BoxFit.fill,  width: 70),
                      ],
                    ),
                    Text('R\$ ${widget.userFlight.total_paid}',
                      style: TextStyle(fontSize: 20, color: Palette.darkOrange)
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => handleTripCancel(),
                  child: Text(
                    "Solicitar cancelamento", 
                    style: TextStyle(fontSize: 18, color: Palette.darkRed, decoration: TextDecoration.underline))
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showConfirmOnRemove(BuildContext context, Function handleDelete) {
    Widget handleCancel = FlatButton(
      child: Text("Cancelar", style: TextStyle(fontSize: 20)),
      onPressed: () { Navigator.of(context).pop(); },
    );

    Widget handleGoOn = FlatButton(
      child: Text("Excluir", style: TextStyle(fontSize: 20, color: Palette.darkRed)),
      onPressed: () => handleDelete(),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Excluir Voo", style: TextStyle(fontSize: 22, color: Palette.darkRed)),
      content: Text("Deseja mesmo excluir esse voo?", style: TextStyle(fontSize: 20)),
      actions: [
        handleCancel,
        handleGoOn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
