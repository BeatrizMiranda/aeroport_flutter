import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class HomeFlightCard extends StatelessWidget {
  HomeFlightCard({this.image, this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195,
      padding: EdgeInsets.all(10),
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
                child: Image.network('https://cdn.pixabay.com/photo/2013/12/18/18/01/bridge-230311_1280.jpg',
                  height: 130,
                  fit: BoxFit.cover,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Dublin – Irlanda", style: TextStyle(fontSize: 20, color: Palette.lightBlack),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}