import 'package:airport/components/Cadastro.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart' as globals;
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyAccount.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';


class BuyTicket extends StatefulWidget {
  BuyTicket({Key key, this.userFlight }) : super(key: key);

  final FlightInfo userFlight;
  
  _BuyTicket createState() => _BuyTicket();
}

class _BuyTicket extends State<BuyTicket> {
  
  String shipDateFormated;
  int qtdAdults = 1;
  int qtdChilds = 0;
  double valorTotal;
  double desconto = 0;
  double total;

   @override
  void initState() {
      print('entrou aqui');
    super.initState();
    setState(() {
      shipDateFormated = DateFormat('dd/MM/y').format(DateTime.parse(widget.userFlight.ship_date));
      valorTotal = widget.userFlight.ticket_price;
      total = valorTotal - desconto;
    });
  }

  void setPassangers(adults, child) {
    setState(() {
      qtdAdults = adults;
      qtdChilds = child;

      print(widget.userFlight.ticket_price * (qtdAdults + qtdChilds));

      valorTotal = widget.userFlight.ticket_price * (qtdAdults + qtdChilds);
      desconto = (widget.userFlight.ticket_price * 0.3) * qtdChilds;
      total = valorTotal - desconto;
    });
  }

  void handleBuy(FlightInfo flight) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Cadastro(goTo: '/viagens')));
    // depois do login faze a api de compra
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
      bottomNavigationBar: Footer(),
      floatingActionButton: FooterFloatingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  Widget _body() { 
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
                renderInfo('Valor unitário', widget.userFlight.ticket_price,
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
                    onPressed: () => handleBuy(widget.userFlight),
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
                    onPressed: () => handleBuy(widget.userFlight),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)
                        ),
                        child: Image.asset('src/img/picpay.png',
                          fit: BoxFit.contain, width: 160
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ]
      ),
    );
  }
}