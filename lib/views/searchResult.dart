import 'package:airport/components/footer.dart';
import 'package:airport/components/tripCard.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<FlightInfo> userFlights = const <FlightInfo>[
  FlightInfo(
    destination: "São Paulo", 
    shipment: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
  FlightInfo(
    shipment: "São Paulo", 
    destination: "Rio de Janeiro", 
    ship_date: "2020-07-02T03:00:00.000Z", 
    ship_time: "18:00:00", 
    estimated_time: "03:00:00", 
    limit:46, 
    airline_id: 1, 
    status: "ativo", 
    image: "https://cdn.pixabay.com/photo/2017/01/08/19/30/rio-de-janeiro-1963744_1280.jpg" 
  ),
];

class FlightSearch {
  const FlightSearch({
    this.destination, 
    this.shipment, 
    this.ship_date, 
    this.quantity
  });

  final String shipment;
  final String ship_date;
  final String destination;
  final int quantity;
}


const FlightSearch flightsOptions = FlightSearch(
  destination: "São Paulo", 
  shipment: "Rio de Janeiro", 
  ship_date: "2020-07-02T03:00:00.000Z", 
  quantity: 5
);


class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}
class _SearchResultState extends State<SearchResult> {
  
  String shipDateFormated = DateFormat('dd/MM/y').format(DateTime.parse(flightsOptions.ship_date));

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
                child: Image.asset(
                  "src/img/searchOpacity.png",
                  fit: BoxFit.contain,
                  height: 220,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 55, 30, 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              flightsOptions.shipment, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                            ),
                            Image.asset(
                              "src/img/planeIcon.png",
                              fit: BoxFit.contain
                            ),
                            Text(
                              flightsOptions.destination, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              shipDateFormated, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                            ),
                            Text(
                              "${flightsOptions.quantity} Tickets", 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${userFlights.length} results found", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                        ),
                        IconButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage())),
                          icon: Icon(Icons.settings, color: Palette.lightBlack, size: 25),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: List.generate(userFlights.length, (index) {
                            return TripCard(
                              userFlight: userFlights[index], 
                              isAdmin: false,
                              handleClick: () {}
                            );
                        })
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),           
        ],
      ),
    );
  }
}
