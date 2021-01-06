import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Company {
  const Company({ this.name, this.logo });

  final String name;
  final String logo;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class NewAirline extends StatefulWidget {
  NewAirline({Key key}) : super(key: key);

  @override
  _NewAirlineState createState() => _NewAirlineState();
}


Future<Company> createCompany(BuildContext context, String name, String image) async {
  var response = await http.post(
      globals.companyAPI, 
      headers: <String, String> {
        'Authorization': 'bearer ${globals.token}',
      },
      body: { "name": name, "logo": '$image' }
    );

  if (response.statusCode == 200) {
    showSuccessMessage(context, 'Airline criado com sucesso!');
    return Company.fromJson(jsonDecode(response.body));
  } else {   
    String errorMessage = response.body.replaceAll(new RegExp("\""), "");
    
    showFailMessage(context, 'Não foi possivel criar a airline', path: "/new-airline");
    throw Exception('Failed ${response.body}');
  }
}

class _NewAirlineState extends State<NewAirline> {

  TextEditingController nameController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  
  void _sendForm() async {
    await createCompany(context, nameController.text, imgController.text);
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
        onClick: () => _sendForm(),
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
