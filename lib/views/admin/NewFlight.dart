import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewFlight extends StatefulWidget {
  final FlightInfo flight;
  final Function onCreate;

  NewFlight({ Key key, this.flight, this.onCreate }) : super(key: key);

  @override
  _NewFlightState createState() => _NewFlightState();
}

Future<FlightInfo> createFlight(
  BuildContext context, 
  String image,
  String destination,
  String shipment,
  String ship_date,
  String ship_time,
  String estimated_time,
  String status,
  String limit,
  String airline_id,
  String ticket_price,
) async {
  
  Map<String, dynamic> body = {
    "image": image,
    "destination": destination,
    "shipment": shipment,
    "ship_date": ship_date,
    "ship_time": ship_time,
    "estimated_time": estimated_time,
    "limit": limit,
    "airline_id": airline_id,
		"ticket_price": ticket_price,
    "status": status
  };

  var response = await http.post(globals.flightApi, 
    headers: <String, String>{
      'Authorization': 'bearer ${globals.token}',
    },
    body: body
  );

  if (response.statusCode == 200) {
    showSuccessMessage(context, 'Voo criado com sucesso');
    return FlightInfo.fromJson(jsonDecode(response.body));
  } else {
    
    showFailMessage(context, 'Não foi possivel criar um voo', path: "/list-flight");
    throw Exception('Failed ${response.body}');
  }
}

Future<FlightInfo> updateFlight(
  BuildContext context, 
  String id,
  String image,
  String destination,
  String shipment,
  String ship_date,
  String ship_time,
  String estimated_time,
  String status,
  String limit,
  String airline_id,
  String ticket_price,
) async {
  
  Map<String, dynamic> body = {
    "image": image,
    "destination": destination,
    "shipment": shipment,
    "ship_date": ship_date,
    "ship_time": ship_time,
    "estimated_time": estimated_time,
    "limit": limit,
    "airline_id": airline_id,
		"ticket_price": ticket_price,
    "status": status
  };

  var response = await http.put('${globals.flightApi}/$id', 
    headers: <String, String>{
      'Authorization': 'bearer ${globals.token}',
    },
    body: body
  );

  if (response.statusCode == 200) {
    Navigator.pushNamed(context, '/list-flight');
    return FlightInfo.fromJson(jsonDecode(response.body));
  } else {
    
    showFailMessage(context, 'Não foi possivel editar o voo', path: "/list-flight");
    throw Exception('Failed ${response.body}');
  }
}

class _NewFlightState extends State<NewFlight> {
  TextEditingController imgController = TextEditingController();
  TextEditingController embarqueController = TextEditingController();
  TextEditingController destinoController = TextEditingController();
  TextEditingController horarioController = TextEditingController();
  TextEditingController tempoEstimadoController = TextEditingController();
  TextEditingController limiteController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController companhiaController = TextEditingController();

  DateTime ship_time;
  DateTime estimated_time;

  DateTime chosedDate = DateTime.now();
  String chosedDateFormated = DateFormat('dd/MM/y').format(DateTime.now());

  String getFormattedTime(DateTime time) {
    if(time == null) return '';

    return '${time.hour}h ${time.minute}min';
  }

  @override
  void initState() {
    super.initState();
    if(widget.flight != null) {
      DateTime horario = DateTime.parse("2020-01-01 ${widget.flight.ship_time}");
      DateTime estTime = DateTime.parse("2020-01-01 ${widget.flight.estimated_time}");
      ship_time = horario;
      estimated_time = estTime;

      imgController = TextEditingController(text: widget.flight.image);
      embarqueController = TextEditingController(text: widget.flight.shipment);
      destinoController = TextEditingController(text: widget.flight.destination);
      horarioController = TextEditingController(text: '$horario');
      tempoEstimadoController = TextEditingController(text: widget.flight.estimated_time);
      limiteController = TextEditingController(text: '${widget.flight.limit}');
      priceController = TextEditingController(text: '${widget.flight.ticket_price}');
      companhiaController = TextEditingController(text: '${widget.flight.airline_id}');
      setState(() {
        chosedDate = DateFormat("dd/MM/yyyy").parse(widget.flight.ship_date);
        chosedDateFormated = DateFormat('dd/MM/y').format(chosedDate);
      });
    }
  }

  void setDate(newDate) {
    setState(() {
      if (newDate != null) {
        chosedDate = newDate;
        chosedDateFormated = DateFormat('dd/MM/y').format(chosedDate);
      }
    });
  }

  void _sendForm() async {
    String formattedDate = DateFormat('dd/MM/y').format(chosedDate);
    String formattedShipTime = "${ship_time.hour}:${ship_time.minute}";
    String formattedEstTime = "${estimated_time.hour}:${estimated_time.minute}";

    if(widget.flight == null) {
      await createFlight(context, 
        imgController.text.trim(),
        embarqueController.text.trim(),
        destinoController.text.trim(),
        '$formattedDate',
        formattedShipTime,
        formattedEstTime,
        "ativo",
        limiteController.text.trim(),
        companhiaController.text.trim(),
        priceController.text.trim(),
      );
    } else {
      await updateFlight(context, 
        "${widget.flight.id}",
        imgController.text.trim(),
        embarqueController.text.trim(),
        destinoController.text.trim(),
        '$formattedDate',
        formattedShipTime,
        formattedEstTime,
        "ativo",
        limiteController.text.trim(),
        companhiaController.text.trim(),
        priceController.text.trim(),
      );
    }
    if(widget.onCreate != null) {
      widget.onCreate();
    }
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
    return Center(
        child: Stack(children: [
      SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 50),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text("Cadastre um novo voo",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack)),
                )),
                Column(children: [_renderForm()]),
                _sendFormBtn()
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  Widget _sendFormBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: CustomButton(
        text: "Enviar",
        onClick: _sendForm,
        height: 50,
      ),
    );
  }

  Widget _renderForm() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomTextField(
              icon: Icons.flight_takeoff,
              label: "Embarque: ",
              controller: embarqueController,
              fontSize: 19,
              padding: 0
          ),
          CustomTextField(
              icon: Icons.flight_land,
              label: "Destino: ",
              controller: destinoController,
              fontSize: 19,
              padding: 0
          ),
          TextField(
            controller: limiteController,
            decoration: InputDecoration(
              labelText: "Limite de passageiros: ",
              labelStyle: TextStyle(
                color: Palette.lightBlack
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
              ),
              prefixIcon: Icon(Icons.supervisor_account, color: Palette.lightBlack),
            ),
            style: TextStyle(fontSize: 19),
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          TextField(
            controller: companhiaController,
            decoration: InputDecoration(
              labelText: "Companhia Aérea: ",
              labelStyle: TextStyle(
                color: Palette.lightBlack
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
              ),
              prefixIcon: Icon(Icons.flight, color: Palette.lightBlack),
            ),
            style: TextStyle(fontSize: 19),
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Preço da passagem: ",
                labelStyle: TextStyle(
                  color: Palette.lightBlack
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
                ),
                prefixIcon: Icon(Icons.attach_money, color: Palette.lightBlack),
              ),
              style: TextStyle(fontSize: 19),
              keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          TextField(
            controller: imgController,
            decoration: InputDecoration(
              labelText: "Imagem: ",
              labelStyle: TextStyle(
                color: Palette.lightBlack
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
              ),
              prefixIcon: Icon(Icons.image, color: Palette.lightBlack),
            ),
            style: TextStyle(fontSize: 19),
          ),
          Container(
            padding: EdgeInsets.only(top: 5), 
            child: dataPicker(context, chosedDate, setDate, chosedDateFormated, 19.0)
          ),
          _shipTime(),
          _estimatedTime(),
        ],
      ),
    );
  }

  Widget _estimatedTime() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Palette.lightBlack),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {});
          DatePicker.showTimePicker(context, 
            showTitleActions: true,
            onConfirm: (time) {
              setState(() {
                estimated_time = time;
              });
            }, 
            locale: LocaleType.en
          );
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 5),
          alignment: Alignment.center,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Tempo estimado: ${getFormattedTime(estimated_time)}",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              Icon(
                Icons.access_time,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _shipTime() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Palette.lightBlack),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {});
          DatePicker.showTimePicker(context, 
            showTitleActions: true,
            onConfirm: (time) {
              setState(() {
                ship_time = time;
              });
            }, 
            locale: LocaleType.en
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Horário: ${getFormattedTime(ship_time)}",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              Icon(
                Icons.access_time,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
