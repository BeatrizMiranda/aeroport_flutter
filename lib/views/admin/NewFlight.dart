import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class NewFlight extends StatefulWidget {
  NewFlight({Key key}) : super(key: key);

  @override
  _NewFlightState createState() => _NewFlightState();
}
class _NewFlightState extends State<NewFlight> {

  TextEditingController embarqueController;
  TextEditingController destinoController;
  TextEditingController dataController;
  TextEditingController horarioController;
  TextEditingController tempoEstimadoController;
  TextEditingController limiteController;
  TextEditingController companhiaController;

  void _nameChange(String text) {
    if(text.isEmpty) return _throwError();
    // nameController.text = text;
  }

  void _throwError() {
    print('empty input');
  }

  void _sendForm() {

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
      child: Stack(
        children:[
          SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Center(child: 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          "Cadastre um novo voo", 
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)
                        ),
                      )
                    ),
                    Column(
                      children: [
                        _renderForm()
                      ]
                    ),
                    _sendFormBtn()
                  ],
                ),
              ),
            ),
          ),
        ] 
      )
    );
  }

  Widget _sendFormBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: CustomButton(
        text : "Enviar",
        onClick: _sendForm,
        height: 50,
      ),
    );
  } 

  Widget _renderForm() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomTextField(icon: Icons.flight_takeoff, label: "Emparque: ", controller: embarqueController, handleChange: _nameChange),
          CustomTextField(icon: Icons.flight_land, label: "Destino: ", controller: destinoController, handleChange: _nameChange),
          CustomTextField(icon: Icons.calendar_today, label: "Data: ", controller: dataController, handleChange: _nameChange),
          CustomTextField(icon: Icons.access_time, label: "Horário: ", controller: horarioController, handleChange: _nameChange),
          CustomTextField(icon: Icons.access_time, label: "Tempo estimado de voo: ", controller: tempoEstimadoController, handleChange: _nameChange),
          CustomTextField(icon: Icons.supervisor_account, label: "Limite de passageiros: ", controller: limiteController, handleChange: _nameChange),
          CustomTextField(icon: Icons.flight, label: "Companhia Aérea: ", controller: companhiaController, handleChange: _nameChange),
        ],
      ),
    );
  }
}
