import 'package:shared_preferences/shared_preferences.dart';
import 'package:airport/components/Cadastro.dart';
import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class User {
  const User({ this.name, this.email, this.token, this.type });

  final String name;
  final String email;
  final String token;
  final String type;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token'],
      type: json['type'],
    );
  }
}

class Logar extends StatefulWidget {
  Logar({Key key, this.goTo }) : super(key: key);

  final String goTo;
  
  _Logar createState() => _Logar();
}

Future<User> signInUser(String email, String password) async {
  final String signInUrl = "http://192.168.0.105:5000/signIn";

  var response = await http.post(
      signInUrl, 
      body: { "email": email, "password": password }
    );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user ${response.body}');
  }
}

Future<bool> signInRequest(String email, String password) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  User user = await signInUser(email, password);

  localStorage.setString('userToken', user.token);
  localStorage.setString('userType', user.type);

  return true;
}
class _Logar extends State<Logar> {

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();


  void _handleSignIn() async {
    await signInRequest(emailController.text.trim(), senhaController.text.trim());
    Navigator.pushNamed(context, widget.goTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
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
                          "Entre", 
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)
                        ),
                      )
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          icon: Icons.alternate_email,
                          label: "Insira seu e-mail: ", 
                          controller: emailController, 
                        ),
                        CustomTextField(icon: Icons.lock,label: "Insira sua senha: ", controller: senhaController, isPassword: true),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: CustomButton(
                            height: 60, 
                            text: "Entre", 
                            onClick: _handleSignIn
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 20),
                           child: GestureDetector(
                              onTap: 
                              () => {

                              Navigator.pushReplacement(context, 
                                MaterialPageRoute(builder: (context) => 
                                  Cadastro(goTo: widget.goTo)
                                )
                              )
                              }
                              ,
                              child: Text(
                                "Não tem cadastro?", 
                                style: TextStyle(fontSize: 20, color: Palette.darkOrange, decoration: TextDecoration.underline))
                            ),
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