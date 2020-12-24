import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class NewAirline extends StatefulWidget {
  NewAirline({Key key}) : super(key: key);

  @override
  _NewAirlineState createState() => _NewAirlineState();
}
class _NewAirlineState extends State<NewAirline> {

  TextEditingController nameController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  
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
              margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Center(child: 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Companhia Aérea", 
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
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomTextField(icon: Icons.flight_takeoff, label: "Nome: ", controller: nameController),
          CustomTextField(icon: Icons.cloud_download, label: "Link pra imagem: ", controller: imgController),
        ],
      ),
    );
  }
}
