import 'dart:convert';

import 'package:airport/components/PassangersPicker.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/dataPicker.dart';
import 'package:airport/components/dropDown.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/searchResult.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

Future<String> getAvailableCities() async {
  var response = await http.get(globals.getAvailableCities);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load user ${response.body}');
  }
}

class _SearchPageState extends State<SearchPage> {
  int qtdAdults = 1;
  int qtdChilds = 0;
  DateTime chosedDate = DateTime.now();
  List<String> listOfCities = [];
  String chosedDateFormated = DateFormat('dd/MM/y').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getCities();
  }

  void getCities() async {
    List<String> newList = List<String>.from(jsonDecode(await getAvailableCities()));
    
    setState(() {
      listOfCities = newList;
    });
  }

  void setPassangers(adults, child) {
    setState(() {
      qtdAdults = adults;
      qtdChilds = child;
    });
  }

  void setDate(newDate) {
    setState(() {
      print(newDate);
      if (newDate != null) {
        chosedDate = newDate;
        chosedDateFormated = DateFormat('dd/MM/y').format(chosedDate);
      }
    });
  }

  void handleSearchFight() {
    print('chegou aqui');
    int qtd = qtdAdults + qtdChilds;

    FlightSearch flightsOptions = FlightSearch(
      destination: "São Paulo",
      shipment: "Rio de Janeiro",
      ship_date: chosedDate,
      quantity: qtd
    );

    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => SearchResult(flightsOptions: flightsOptions))
    );
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
    return Stack(children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: Image.asset("src/img/SearchImg.png",
            fit: BoxFit.cover, height: 325),
      ),
      Positioned(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _searchForm(),
          ],
        ),
      )
    ]);
  }

  Widget _searchForm() {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 20, 20, 20),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 40, 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Como será o seu voo?",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Palette.lightBlack),
              ),
              _shipAndDestination(),
              passangersPicker(context, qtdAdults, qtdChilds, setPassangers),
              dataPicker(context, chosedDate, setDate, chosedDateFormated, 27.0),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: CustomButton(
                  height: 50,
                  text: "Buscar",
                  onClick: () => handleSearchFight(),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _shipAndDestination() {
    return Container(
        color: Palette.grayBackground,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: DropDown(dropdownList: listOfCities, icon: Icons.flight_takeoff, placeholder: "Local de partida"),
            ),
            Divider(color: Colors.white, thickness: 3),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: DropDown(
                  dropdownList: listOfCities,
                  icon: Icons.flight_land,
                  placeholder: "Local de chegada"),
            ),
          ],
        ));
  }
}

Widget dataPicker(context, chosedDate, setDate, chosedDateFormated, dataLabelSize) {
  return Container(
      padding: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Palette.lightBlack),
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          var response = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DatePicker(initialDate: chosedDate)));
          if (response != null) setDate(response.selectedDate);
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Data: ",
                    style: TextStyle(
                        fontSize: dataLabelSize,
                        fontWeight: FontWeight.bold,
                        color: Palette.lightBlack),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      chosedDateFormated,
                      style: TextStyle(
                          fontSize: dataLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack),
                    ),
                  ),
                ],
              ),
              Icon(Icons.calendar_today, size: 25)
            ],
          ),
        ),
      ));
}

Widget iconText(text, icon, isBold) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(icon, size: 28, color: Palette.lightBlack),
        ),
        Text(text,
            style: TextStyle(
                fontSize: 20, color: Palette.lightBlack, fontWeight: isBold)),
      ]));
}

Widget passangersPicker(context, qtdAdults, qtdChilds, setPassangers) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text("Passagens: ",
            style: TextStyle(fontSize: 20, color: Palette.lightBlack)),
      ),
      RaisedButton(
          color: Palette.grayBackground,
          child: Container(
            child: Column(
              children: [
                iconText(
                    "$qtdAdults Adulto(s)", Icons.person, FontWeight.normal),
                iconText(
                    "$qtdChilds Criança(s)", Icons.face, FontWeight.normal),
              ],
            ),
          ),
          onPressed: () async {
            var response = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PassangersPicker(
                        adults: qtdAdults, childs: qtdChilds)));
            if (response != null)
              setPassangers(response["Adult"], response["Child"]);
          }),
    ],
  );
}
