import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/admin/NewFlight.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;

class TripCard extends StatefulWidget {
  TripCard({Key key, this.userFlight, this.isAdmin, this.handleClick})
      : super(key: key);

  final FlightInfo userFlight;
  final bool isAdmin;
  final Function handleClick;

  @override
  _TripCard createState() => _TripCard();
}

void flightDelete(BuildContext context, int id) async {
  var response = await http.delete(
    '${globals.flightApi}/$id', 
    headers: <String, String>{
      'Authorization': 'bearer ${globals.token}',
    }
  );

  if (response.statusCode == 200) {
    showSuccessMessage(context, 'Voo deletado com sucesso');
  } else {
    showFailMessage(context, 'Não foi possivel deletar o voo, ${response.body}');
    throw Exception('Failed ${response.body}');
  }
}

class _TripCard extends State<TripCard> {
  @override
  Widget build(BuildContext context) {

    void handleDelete() async {
      flightDelete(context, widget.userFlight.id);
      Navigator.of(context).pop();
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
      onTap: widget.handleClick,
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
                padding: EdgeInsets.only(top: 25),
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
              widget.isAdmin
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showConfirmOnRemove(context, handleDelete);
                              },
                              icon: Icon(Icons.delete, color: Palette.darkRed)
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewFlight()
                                  )
                                );
                              },
                              icon: Icon(Icons.edit)
                            ),
                          ]),
                    )
                  : Container(),
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
