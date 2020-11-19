import 'package:airport/components/homeFlightCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class HomeFlightSugestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          "Descubra Sua Próxima Aventura!", 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Palette.lightBlack)
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Column(
            children: [
              Row(
                children: [
                  HomeFlightCard(),
                  HomeFlightCard(),
                ],
              ),
              Row(
                children: [
                  HomeFlightCard(),
                  HomeFlightCard(),
                ],
              ),
              Row(
                children: [
                  HomeFlightCard(),
                  HomeFlightCard(),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}