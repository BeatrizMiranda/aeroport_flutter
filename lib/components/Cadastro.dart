import 'package:airport/components/Logar.dart';
import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';



class Cadastro extends StatefulWidget {
  Cadastro({Key key, this.goTo }) : super(key: key);

  final String goTo;
  
  _Cadastro createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {

  TextEditingController cpfController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController(); 
  TextEditingController senhaController = TextEditingController();

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
                        CustomTextField(icon: Icons.lock,label: "Senha: ", controller: senhaController),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: CustomButton(
                            height: 60, 
                            text: "Entre", 
                            onClick: () => Navigator.pushNamed(context, widget.goTo) 
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