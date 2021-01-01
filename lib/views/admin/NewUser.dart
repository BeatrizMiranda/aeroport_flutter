import 'package:airport/components/Cadastro.dart';
import 'package:airport/components/TextField.dart';
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/globals.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';

import 'package:airport/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NewUserForm extends StatefulWidget {
  NewUserForm({Key key}) : super(key: key);

  @override
  _NewUserFormState createState() => _NewUserFormState();
}

Future<NewUser> createAdminUser(BuildContext context, String email, String password, String name, String cpf) async {
  bool isAdmin = globals.isAdmin;

  if(!isAdmin) {
    String errorMessage = 'User not allowed to do this request';
    
    showFailMessage(context, errorMessage);
    throw Exception(errorMessage);
  };

  SharedPreferences localStorage = await SharedPreferences.getInstance();
  String token = localStorage.getString('userToken');
  globals.token = token;

  var response = await http.post(
      globals.createAdminApi, 
      headers: <String, String>{
        'Authorization': 'bearer $token',
      },
      body: { 
        "name": name, 
        "email": email,
        "cpf": cpf,
        "password": password
      }
    );

  if (response.statusCode == 200) {
    showSuccessMessage(context, 'Usuário criado com sucesso!');
    return NewUser.fromJson(jsonDecode(response.body));
  } else {
    String errorMessage = response.body.replaceAll(new RegExp("\""), "");
    
    showFailMessage(context, 'Não foi possivel criar o usuario, $errorMessage');
    throw Exception('Failed to load user $errorMessage');
  }
}
class _NewUserFormState extends State<NewUserForm> {

  TextEditingController cpfController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController(); 
  TextEditingController senhaController = TextEditingController();
    

  void _sendForm() async {
    await createAdminUser(
      context,
      emailController.text.trim(),
      senhaController.text.trim(),
      nameController.text.trim(),
      cpfController.text.trim()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => _body()
      ),
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
                          "Novo Usuário", 
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
          CustomTextField(icon: Icons.account_circle, label: "Nome: ", controller: nameController),
          CustomTextField(icon: Icons.fingerprint, label: "CPF: ", controller: cpfController),
          CustomTextField(icon: Icons.alternate_email,label: "Email: ", controller: emailController),
          CustomTextField(icon: Icons.lock,label: "Senha: ", controller: senhaController, isPassword: true),
        ],
      ),
    );
  }

  showAlertDialog2(BuildContext context) {
    Widget handleCancel = FlatButton(
      child: Text("Cancelar", style: TextStyle(fontSize: 20)),
      onPressed: () { Navigator.of(context).pop(); },
    );

    Widget handleGoOn = FlatButton(
      child: Text("Excluir", style: TextStyle(fontSize: 20, color: Palette.darkRed)),
      onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())); },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Excluir Usuário", style: TextStyle(fontSize: 22, color: Palette.darkRed)),
      content: Text("Deseja mesmo excluir seu usuário?", style: TextStyle(fontSize: 20)),
      actions: [
        handleCancel,
        handleGoOn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}