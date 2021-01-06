import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airport/globals/globals.dart' as globals;
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
  Logar({Key key, this.goTo, this.stayOnComponent = false }) : super(key: key);

  final String goTo;
  final bool stayOnComponent;
  
  _Logar createState() => _Logar();
}

Future<User> signInUser(BuildContext context, String email, String password) async {
  var response = await http.post(
      globals.signInApi, 
      body: { "email": email, "password": password }
    );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    showFailMessage(context, 'Usuário não encontrado', path: "/home");
    throw Exception('Failed to load user ${response.body}');
  }
}

Future<bool> signInRequest(BuildContext context, String email, String password) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  User user = await signInUser(context, email, password);

  localStorage.setString('userToken', user.token ?? '');
  localStorage.setString('userType', user.type ?? '');

  String userType = localStorage.getString('userType');  

  globals.isAdmin = userType == 'admin';
  globals.token = user.token ?? '';
  globals.userName = user.name ?? '';

  return true;
}
class _Logar extends State<Logar> {

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();


  void _handleSignIn() async {
    await signInRequest(context, emailController.text.trim(), senhaController.text.trim());
    
    if(widget.stayOnComponent == true) {
      Navigator.pop(context, globals.token != '');
    } else {
      Navigator.pushNamed(context, widget.goTo);
    }
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