import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripCard extends StatefulWidget {
  TripCard({Key key, this.userFlight, this.isAdmin}) : super(key: key);

  final FlightInfo userFlight;
  final bool isAdmin;

  @override
  _TripCard createState() => _TripCard();
}

class _TripCard extends State<TripCard> {

  @override
  Widget build(BuildContext context) {
    String flightDate = widget.userFlight.ship_date.split('T')[0];

    DateTime parseShipDate = DateTime.parse("${flightDate}T${widget.userFlight.ship_time}");
    DateTime parsedEstimatedHours = DateTime.parse("${flightDate}T${widget.userFlight.estimated_time}");
    DateTime deliveryTime = parseShipDate.add(Duration(minutes: (parsedEstimatedHours.hour * 60) + parsedEstimatedHours.minute));
    
    String deliveryTimeFormated = DateFormat.Hm().format(deliveryTime);
    String shipTimeFormated = DateFormat.Hm().format(parseShipDate);
    String shipDateFormated = DateFormat('dd/MM/y').format(parseShipDate);
    String estimatedHoursFormated = "${DateFormat('hh').format(parsedEstimatedHours)}h${DateFormat('mm').format(parsedEstimatedHours)}min de voo";
    return Card(
      margin: EdgeInsets.only(bottom: 25),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.userFlight.shipment, 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                ),
                Image.asset(
                  "src/img/planeIcon.png",
                  fit: BoxFit.contain
                ),
                Text(
                  widget.userFlight.destination, 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shipTimeFormated, 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                Text(
                  '$deliveryTimeFormated', 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shipDateFormated, 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                  Text(
                    estimatedHoursFormated, 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                ],
              ),
            ),
            widget.isAdmin ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.delete, color: Palette.darkRed),
                  Icon(Icons.edit)
                ]
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
 