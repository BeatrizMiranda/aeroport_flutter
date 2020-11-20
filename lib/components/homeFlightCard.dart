import 'package:airport/layout/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';


class HomeFlightCard extends StatelessWidget {
  const HomeFlightCard({Key key, this.flightSuggestion}) : super(key: key);
  final FlightSuggestion flightSuggestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {},
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight:  Radius.circular(10), topLeft:  Radius.circular(10)),
                child: Image.network(flightSuggestion.img,
                  height: 130,
                  fit: BoxFit.cover,
                  width: 200,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  flightSuggestion.title, style: TextStyle(fontSize: 20, color: Palette.lightBlack),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}