import 'package:airport/components/Cadastro.dart';
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
        ticket_price: 150.00,
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
        ticket_price: 150.00,
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
        ticket_price: 150.00,
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
        ticket_price: 150.00,
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
        ticket_price: 150.00,
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

  void handleBuy(FlightInfo flight) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Cadastro(goTo: '/viagens')));
    // depois do login faze a api de compra
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

    int qtdAdults = 1;
    int qtdChilds = 0;
    double valorTotal = userFlight.ticket_price;
    double desconto = 0;
    double total = valorTotal - desconto;

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

        print(userFlight.ticket_price * (qtdAdults + qtdChilds));

        valorTotal = userFlight.ticket_price * (qtdAdults + qtdChilds);
        desconto = (userFlight.ticket_price * 0.3) * qtdChilds;
        total = valorTotal - desconto;
      });
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.close, size: 35)),
                    ),
                    Center(
                      child: Text("Comprar Passagem",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Palette.lightBlack)),
                    ),
                  ]),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: passangersPicker(
                            context, qtdAdults, qtdChilds, setPassangers),
                      ),
                      renderInfo('Embarque no dia', shipDateFormated, 22.0,
                          Palette.lightBlue),
                      renderInfo('Valor unitário', userFlight.ticket_price,
                          22.0, Palette.lightBlue),
                      renderInfo('Valor total de Passagens', valorTotal, 22.0,
                          Palette.lightBlue),
                      (desconto != 0.0)
                          ? Column(
                              children: [
                                renderInfo('Desconto', desconto, 22.0,
                                    Palette.lightBlue),
                                Divider(
                                  thickness: 2,
                                )
                              ],
                            )
                          : Divider(
                              thickness: 2,
                            ),
                      renderInfo('Total', total, 22.0, Palette.lightBlue),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () => handleBuy(userFlight),
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
                          onPressed: () => handleBuy(userFlight),
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
                    ),
                  )
                ]),
          );
        });
  }
}
