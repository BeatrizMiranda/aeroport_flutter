import 'package:airport/layout/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  bool isAdmin = false;
  bool rodrigo = false;

  Map<String, IconData> normalUser = {
    'Minha Conta': Icons.account_circle,
    'Minhas Viagens': Icons.card_travel
  };

  Map<String, IconData> adminUser = {
    'Usuários': Icons.supervised_user_circle,
    'Minha Conta': Icons.account_circle,
    'Voos': Icons.flight_takeoff,
    'Companhia': Icons.flight
  };

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 70.0,
        child: Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: isAdmin
                ? getFooterIcons(adminUser)
                : getFooterIcons(normalUser)),
      ),
    );
  }

  Widget getFooterIcons(Map<String, IconData> footerItems) {
    List<Widget> list = List<Widget>();
    footerItems
        .forEach((message, icon) => list.add(_footerItem(message, icon)));
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list);
  }

  Widget _footerItem(text, icon) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      IconButton(
          onPressed: () {},
          icon: Icon(icon, size: 30, color: Palette.lightBlack)),
      Text(text)
    ]);
  }
}

class FooterFloatingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())),
          tooltip: 'Tela de Início',
          child: Container(
            width: 70,
            height: 70,
            child: Icon(Icons.flight, size: 35),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Palette.darkOrange, Palette.lightOrange])),
          ),
        ),
      ),
    );
  }
}
