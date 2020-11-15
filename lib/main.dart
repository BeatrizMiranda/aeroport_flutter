import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Time To Travel',
    home: Home(),
    theme: ThemeData(
      hintColor: Color(0xFFFFA251),
      primaryColor: Colors.white,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _footer(),
      floatingActionButton: _footerFloatingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Color(0xFFF2F2F2),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ],
      ),
    );
  }

  Widget _footer() {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0, 
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _footerItem('Minha Conta', Icons.account_circle),
                  _footerItem('Minhas Viagens', Icons.card_travel),
                ],
              ),
          ), 
        ),
      );
  }
  Widget _footerItem(text, icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(icon, size: 30, color: Color(0xFF333333))),
        Text(text)
      ]);
  }

  Widget _footerFloatingBtn() {
    return Container(
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
            onPressed: () => {},
            tooltip: 'Tela de Início',
            child: Container(
                width: 70,
                height: 70,
                child: Icon(Icons.flight, size: 35),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xFFFF5929), 
                      Color(0xFFFFB162)
                    ])
                  ),
            ),
          ),
        ),
      );
  }
}
