import 'package:airport/components/PassangersPicker.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/dataPicker.dart';
import 'package:airport/components/dropDown.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/searchResult.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int qtdAdults = 1;
  int qtdChilds = 0;
  DateTime chosedDate = DateTime.now();
  String chosedDateFormated = DateFormat('dd/MM/y').format(DateTime.now());

  void setPassangers(adults, child) {
    setState(() {
      if (adults.isNotEmpty) {
        int adultsFinal = int.parse(adults);
        qtdAdults = adultsFinal;
      }
      if (child.isNotEmpty) {
        int childFinal = int.parse(child);
        qtdChilds = childFinal;
      }
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
              dataPicker(context, chosedDate, setDate, chosedDateFormated, 27.0),
              passangersPicker(context, qtdAdults, qtdChilds, setPassangers),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: CustomButton(
                  height: 50,
                  text: "Buscar",
                  onClick: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchResult())),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _shipAndDestination() {
    return Container(
        color: Palette.grayBackground,
        margin: EdgeInsets.only(bottom: 30, top: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: DropDown(dropdownList: [
                'São Paulo',
                'Rio de Janeiro',
                'Santa Catarina'
              ], icon: Icons.flight_takeoff, placeholder: "Local de partida"),
            ),
            Divider(color: Colors.white, thickness: 3),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: DropDown(
                  dropdownList: ['Rio de Janeiro', 'São Paulo', 'Bahia'],
                  icon: Icons.flight_land,
                  placeholder: "Local de chegada"),
            ),
          ],
        ));
  }
}

Widget dataPicker(context, chosedDate, setDate, chosedDateFormated, dataLabelSize) {
  return Container(
      padding: EdgeInsets.only(top: 10),
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
                          fontSize: 21,
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
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
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
