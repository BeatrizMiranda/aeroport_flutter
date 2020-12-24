import 'package:airport/components/Logar.dart';
import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class NewUser {
  const NewUser({ this.name, this.email, this.id });

  final int id;
  final String name;
  final String email;

  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }
}


class Cadastro extends StatefulWidget {
  Cadastro({Key key, this.goTo }) : super(key: key);

  final String goTo;
  
  _Cadastro createState() => _Cadastro();
}

Future<NewUser> logInRequest(String email, String password, String name, String cpf) async {
  final String logInUrl = "http://192.168.0.105:5000/user";

  var response = await http.post(
      logInUrl, 
      body: { 
        "name": name, 
        "email": email,
        "cpf": cpf,
        "password": password
      }
    );

  print({"email": email, "password": password});

  if (response.statusCode == 200) {
    return NewUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user ${response.body}');
  }
}

class _Cadastro extends State<Cadastro> {

  Future<NewUser> futureUser;
  TextEditingController emailController = TextEditingController(); 
  TextEditingController senhaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
    );
  }


  void _handleLogIn() async {
    await logInRequest(
      emailController.text.trim(),
      senhaController.text.trim(),
      nameController.text.trim(),
      cpfController.text.trim()
    );

    await signInRequest(emailController.text.trim(), senhaController.text.trim());

    Navigator.pushNamed(context, widget.goTo);
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
                          "Cadastre-se", 
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)
                        ),
                      )
                    ),
                    Column(
                      children: [
                        CustomTextField(icon: Icons.account_circle, label: "Nome: ", controller: nameController),
                        CustomTextField(icon: Icons.fingerprint, label: "CPF: ", controller: cpfController),
                        CustomTextField(icon: Icons.alternate_email,label: "Email: ", controller: emailController),
                        CustomTextField(icon: Icons.lock,label: "Senha: ", controller: senhaController, isPassword: true),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: CustomButton(
                            height: 60, 
                            text: "Entre", 
                            onClick: _handleLogIn
                          ),
                        ),
                         GestureDetector(
                            onTap: () { 
                              Navigator.pushReplacement(context, 
                                MaterialPageRoute(builder: (context) => 
                                  Logar(goTo: widget.goTo)
                                )
                              );
                            },
                            child: Text(
                              "Já tem cadastro?", 
                              style: TextStyle(fontSize: 20, color: Palette.darkOrange, decoration: TextDecoration.underline))
                          ),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ] 
      )
    );
  }
}