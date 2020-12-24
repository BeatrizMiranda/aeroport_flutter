import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewFlight extends StatefulWidget {
  NewFlight({Key key}) : super(key: key);

  @override
  _NewFlightState createState() => _NewFlightState();
}

class _NewFlightState extends State<NewFlight> {
  TextEditingController embarqueController = TextEditingController();
  TextEditingController destinoController = TextEditingController();
  TextEditingController horarioController = TextEditingController();
  TextEditingController tempoEstimadoController = TextEditingController();
  TextEditingController limiteController = TextEditingController();
  TextEditingController companhiaController = TextEditingController();

  String ship_time = "";
  String estimated_time = "";

  DateTime chosedDate = DateTime.now();
  String chosedDateFormated = DateFormat('dd/MM/y').format(DateTime.now());

  void setDate(newDate) {
    setState(() {
      print(newDate);
      if (newDate != null) {
        chosedDate = newDate;
        chosedDateFormated = DateFormat('dd/MM/y').format(chosedDate);
      }
    });
  }

  void _sendForm() {}

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
      padding: EdgeInsets.only(top: 10, bottom: 20),
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
              label: "Emparque: ",
              controller: embarqueController),
          CustomTextField(
              icon: Icons.flight_land,
              label: "Destino: ",
              controller: destinoController),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
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
              style: TextStyle(fontSize: 22),
              keyboardType: TextInputType.numberWithOptions(decimal: true)
            ),
          ),
          CustomTextField(
            icon: Icons.flight,
            label: "Companhia Aérea: ",
            controller: companhiaController,
          ),
          Container(
            padding: EdgeInsets.only(top: 20), 
            child: dataPicker(context, chosedDate, setDate, chosedDateFormated, 22.0)
          ),
          _shipTime(),
          _estimatedTime(),
        ],
      ),
    );
  }

  Widget _estimatedTime() {
    return Container(
      padding: EdgeInsets.only(top: 10),
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
              print('$time');
              estimated_time = '${time.hour}h ${time.minute}min';
              setState(() {});
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
                "Tempo estimado: $estimated_time",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
      padding: EdgeInsets.only(top: 10),
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
              print('$time');
              ship_time = '${time.hour}h ${time.minute}min';
              setState(() {});
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
                "Horário: $ship_time",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
