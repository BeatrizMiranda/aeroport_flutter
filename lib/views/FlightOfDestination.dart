import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyAccount.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/home.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightOfDestination extends StatefulWidget {
  FlightOfDestination({Key key, this.flightSuggestion}) : super(key: key);

  final FlightSuggestion flightSuggestion;

  @override
  _FlightOfDestinationState createState() => _FlightOfDestinationState();
}

class _FlightOfDestinationState extends State<FlightOfDestination> {
  ///TODO: get flight by destination

  List<FlightInfo> userFlights = <FlightInfo>[
    FlightInfo(
        destination: "São Paulo",
        shipment: "Rio de Janeiro",
        ship_date: "2020-07-02T03:00:00.000Z",
        ship_time: "18:00:00",
        estimated_time: "03:00:00",
        limit: 46,
        airline_id: 1,
        status: "ativo",
        image:
            "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg"),
    FlightInfo(
        destination: "Rio de Janeiro",
        shipment: "São Paulo",
        ship_date: "2020-07-02T03:00:00.000Z",
        ship_time: "18:00:00",
        estimated_time: "03:00:00",
        limit: 46,
        airline_id: 1,
        status: "ativo",
        image:
            "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg"),
    FlightInfo(
        destination: "Rio de Janeiro",
        shipment: "São Paulo",
        ship_date: "2020-07-02T03:00:00.000Z",
        ship_time: "18:00:00",
        estimated_time: "03:00:00",
        limit: 46,
        airline_id: 1,
        status: "ativo",
        image:
            "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg"),
    FlightInfo(
        destination: "Rio de Janeiro",
        shipment: "São Paulo",
        ship_date: "2020-07-02T03:00:00.000Z",
        ship_time: "18:00:00",
        estimated_time: "03:00:00",
        limit: 46,
        airline_id: 1,
        status: "ativo",
        image:
            "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg"),
    FlightInfo(
        destination: "Rio de Janeiro",
        shipment: "São Paulo",
        ship_date: "2020-07-02T03:00:00.000Z",
        ship_time: "18:00:00",
        estimated_time: "03:00:00",
        limit: 46,
        airline_id: 1,
        status: "ativo",
        image:
            "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg"),
  ];

  int qtdAdults = 1;
  int qtdChilds = 0;

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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Image.network(widget.flightSuggestion.img,
                    fit: BoxFit.fill),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                alignment: Alignment.topLeft,
                child: Text(widget.flightSuggestion.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
              _listOfFlights()
            ],
          ),
        ),
      ],
    );
  }

  Widget _listOfFlights() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: List.generate(userFlights.length, (index) {
          return TripCard(
              userFlight: userFlights[index],
              handleClick: () {
                showAlertDialog(context, userFlights[index]);
              },
              isAdmin: false);
        }),
      ),
    );
  }

  showAlertDialog(BuildContext context, FlightInfo userFlight) {
    String shipDateFormated =
        DateFormat('dd/MM/y').format(DateTime.parse(userFlight.ship_date));

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close)),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Comprar Passagem",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: passangersPicker(
                    context, qtdAdults, qtdChilds, setPassangers),
              ),
              renderInfo('Embarque no dia', shipDateFormated, 20.0),
              renderInfo('Valor das Passagens', userData.name, 20.0),
              renderInfo('Desconto', userData.name, 20.0),
              renderInfo('Total', userData.name, 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {/* pay with mercadopago*/},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: Image.asset('src/img/mercadopago.png',
                            fit: BoxFit.contain, width: 160),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {/* pay with mercadopago*/},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: Image.asset('src/img/picpay.png',
                            fit: BoxFit.contain, width: 160),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
        });
  }
}
