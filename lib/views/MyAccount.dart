import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

const UserInfo userData = UserInfo(
    id: 1, name: "João Carlos", email: "teste@teste.com", cpf: "12333212");

class MyAccount extends StatefulWidget {
  MyAccount({Key key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController cpfController;

  final senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: userData.name);
    emailController = TextEditingController(text: userData.email);
    cpfController = TextEditingController(text: userData.cpf);
  }

  void _handleLogOut() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.remove('userToken');
    localStorage.remove('userType');

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }

  bool _isEditing = false;

  void _changeToForm() {
    setState(() {
      _isEditing = true;
    });
  }

  void _sendForm() {
    setState(() {
      _isEditing = false;
    });
  }

  void _nameChange(String text) {
    if (text.isEmpty) return _throwError();
    // nameController.text = text;
  }

  void _throwError() {
    print('empty input');
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
                  _isEditing ? _renderForm(userData) : _renderUserData()
                ]),
                _isEditing ? _sendFormBtn() : _editAndDeleteBtn(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 20),
                  child: GestureDetector(
                    onTap: _handleLogOut,
                    child: Text(
                      "Deslogar", 
                      style: TextStyle(fontSize: 20, color: Palette.darkOrange, decoration: TextDecoration.underline))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  Widget _editAndDeleteBtn() {
    return Row(
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
    );
  }

  Widget _renderUserData() {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 20),
          child: Column(
            children: [
              renderInfo('Nome', userData.name, 23.0, Palette.lightBlack),
              renderInfo("Email", userData.email, 23.0, Palette.lightBlack),
              renderInfo("CPF", userData.cpf, 23.0, Palette.lightBlack),
              renderInfo("Senha", "***********", 23.0, Palette.lightBlack),
            ],
          )),
    ]);
  }

  Widget _sendFormBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: CustomButton(
        text: "Enviar",
        onClick: _sendForm,
        height: 50,
      ),
    );
  }

  Widget _renderForm(userData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextField("Nome: ", nameController, _nameChange),
          buildTextField("Email: ", emailController, _nameChange),
          buildTextField("CPF: ", cpfController, _nameChange),
          buildTextField("Senha: ", senhaController, _nameChange, isPassword: true),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, Function handleChange, { bool isPassword = false }) {
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
        onChanged: handleChange,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget handleCancel = FlatButton(
      child: Text("Cancelar", style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget handleGoOn = FlatButton(
      child: Text("Excluir",
          style: TextStyle(fontSize: 20, color: Palette.darkRed)),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
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
