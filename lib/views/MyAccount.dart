import 'package:airport/views/admin/NewUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airport/globals/globals.dart' as globals;
import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfo {
  const UserInfo({
    this.id,
    this.name,
    this.email,
    this.cpf,
  });

  final int id;
  final String name;
  final String email;
  final String cpf;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cpf: json['cpf'],
    );
  }
}

Future<UserInfo> userRequest(String token) async {
  var response = await http.get(globals.userApi, 
    headers: <String, String> {
      'Authorization': 'bearer $token',
    }
  );

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user ${response.body}');
  }
}

Future<UserInfo> userDelete(String token) async {
  var response = await http.delete(globals.userApi, 
    headers: <String, String>{
      'Authorization': 'bearer $token',
    }
  );

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user ${response.body}');
  }
}

Future<UserInfo> updateUserRequest(BuildContext context, String name, String email, String cpf, String password, String token) async {
  Map<String, String> pwd = password.isNotEmpty ? { "password": password } : {};
  
  Map<String, String> body = {
      "name": name, 
      "email": email,
      "cpf": cpf,
      ...pwd
    };

  var response = await http.put(globals.userApi, 
    headers: <String, String>{
      'Authorization': 'bearer $token',
    },
    body: body
  );


  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    
    showFailMessage(context, 'Não foi possivel atualizar o usuario, ${response.body}');
    throw Exception('Failed to load user ${response.body}');
  }
}


class MyAccount extends StatefulWidget {
  MyAccount({Key key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  
  bool _isEditing = false;
  UserInfo userInfo = UserInfo();
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController cpfController;
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString('userToken');
    globals.token = token;
    return token;
  }

  void _getUserData() async {
    String token = await getToken(); 
    UserInfo user = await userRequest(token);
    setUserData(user);
  }

  void setUserData(UserInfo user) {
    setState(() {
      userInfo = user;
      nameController = TextEditingController(text: user.name);
      emailController = TextEditingController(text: user.email);
      cpfController = TextEditingController(text: user.cpf);
    });
  }

  void handleLogOut() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.remove('userToken');
    localStorage.remove('userType');

    globals.isLoged = false;
    globals.isAdmin = false;
    globals.token = '';

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }


  void _changeToUserData() {
    setState(() {
      _isEditing = false;
    });
  }

  void _changeToForm() {
    setState(() {
      _isEditing = true;
    });
  }

  void _sendForm() async {
    String token = await getToken();

    UserInfo user = await updateUserRequest(
      context,
      nameController.text,
      emailController.text,
      cpfController.text,
      senhaController.text,
      token
    );

    setUserData(user);
    _changeToUserData();
  }

  void _handleDeleteUser() async {
    await userDelete(globals.token);
    handleLogOut();

    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Home())
    );
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
        child: Stack(children: [
      SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text("Meus Dados",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack)),
                )),
                Column(children: [
                  _isEditing ? _renderForm(userInfo) : _renderUserData()
                ]),
                _isEditing ? _sendFormBtn() : _editAndDeleteBtn(),
               
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  Widget _editAndDeleteBtn() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: Icon(Icons.delete, size: 30, color: Palette.darkRed)),
            IconButton(
                onPressed: _changeToForm,
                icon: Icon(Icons.edit, size: 30, color: Palette.lightBlack)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 20),
          child: GestureDetector(
            onTap: handleLogOut,
            child: Text(
              "Deslogar", 
              style: TextStyle(fontSize: 20, color: Palette.darkOrange, decoration: TextDecoration.underline))
          ),
        ),
      ],
    );
  }



  Widget _renderUserData() {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 20),
          child: Column(
            children: [
              renderInfo('Nome', userInfo.name, 23.0, Palette.lightBlack),
              renderInfo("Email", userInfo.email, 23.0, Palette.lightBlack),
              renderInfo("CPF", userInfo.cpf, 23.0, Palette.lightBlack),
              renderInfo("Senha", "***********", 23.0, Palette.lightBlack),
            ],
          )),
    ]);
  }
  Widget _sendFormBtn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: CustomButton(
            text: "Enviar",
            onClick: _sendForm,
            height: 50,
          ),
        ),
        FlatButton(
          child: Text("Cancelar", style: TextStyle(fontSize: 20)),
          onPressed: _changeToUserData,
        )
      ],
    );
  }

  Widget _renderForm(userData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextField("Nome: ", nameController),
          buildTextField("Email: ", emailController),
          buildTextField("CPF: ", cpfController),
          buildTextField("Senha: ", senhaController, isPassword: true),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, { bool isPassword = false }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Palette.lightBlack),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Palette.lightOrange, width: 2.0),
          ),
        ),
        style: TextStyle(fontSize: 22),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget handleCancel = FlatButton(
      child: Text("Cancelar", style: TextStyle(fontSize: 20)),
      onPressed: () { Navigator.of(context).pop(); },
    );

    Widget handleGoOn = FlatButton(
      child: Text("Excluir",
          style: TextStyle(fontSize: 20, color: Palette.darkRed)),
      onPressed: _handleDeleteUser,
    );

    AlertDialog alert = AlertDialog(
      title: Text("Excluir Usuário",
          style: TextStyle(fontSize: 22, color: Palette.darkRed)),
      content: Text("Deseja mesmo excluir seu usuário?",
          style: TextStyle(fontSize: 20)),
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

Widget renderInfo(label, value, fontSize, valueColor) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 15),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text('$label: ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
          Text('$value',
              style: TextStyle(fontSize: fontSize - 1, color: valueColor)),
        ],
      ),
    ),
  );
}
