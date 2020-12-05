import 'package:airport/components/Cadastro.dart';
import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';



class Logar extends StatefulWidget {
  Logar({Key key, this.goTo }) : super(key: key);

  final String goTo;
  
  _Logar createState() => _Logar();
}

class _Logar extends State<Logar> {

  TextEditingController emailController; 
  TextEditingController senhaController;

  void _inputChange(String text) {
    if(text.isEmpty) return;
    // nameController.text = text;
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
                        CustomTextField(icon: Icons.alternate_email,label: "Insira seu e-mail: ", controller: emailController, handleChange: _inputChange),
                        CustomTextField(icon: Icons.lock,label: "Insira sua senha: ", controller: senhaController, handleChange: _inputChange),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: CustomButton(
                            height: 60, 
                            text: "Entre", 
                            onClick: () => Navigator.pushNamed(context, widget.goTo) 
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 20),
                           child: GestureDetector(
                              onTap: () { 
                                Navigator.pushReplacement(context, 
                                  MaterialPageRoute(builder: (context) => 
                                    Cadastro(goTo: widget.goTo)
                                  )
                                );
                              },
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