import 'package:airport/layout/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';

class FooterIcon {
  const FooterIcon({this.name, this.icon, this.goToComponent});

  final String name;
  final IconData icon;
  final Type goToComponent;
}

const List<FooterIcon> normalUser = const <FooterIcon>[
  const FooterIcon(name: 'Minha Conta', icon: Icons.account_circle, goToComponent: Home),
  const FooterIcon(name: 'Minhas Viagens', icon: Icons.card_travel, goToComponent: Home),
];

const List<FooterIcon> adminUser = const <FooterIcon>[
  const FooterIcon(name: 'Usuários', icon: Icons.supervised_user_circle, goToComponent: Home),
  const FooterIcon(name: 'Minha Conta', icon: Icons.account_circle, goToComponent: Home),
  const FooterIcon(name: 'Voos', icon: Icons.flight_takeoff, goToComponent: Home),
  const FooterIcon(name: 'Companhia', icon: Icons.flight, goToComponent: Home),
];


class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {

  bool isAdmin = true;
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0, 
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: isAdmin ? getFooterIcons(adminUser) : getFooterIcons(normalUser)
          ), 
        ),
      );
  }

  Widget getFooterIcons(List<FooterIcon> footerItems) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: List.generate(footerItems.length, (index) {
          return FooterOption(footerIcon: footerItems[index]);
      })
    );
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
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
          tooltip: 'Tela de Início',
          child: Container(
            width: 70,
            height: 70,
            child: Icon(Icons.flight, size: 35),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Palette.darkOrange, 
                Palette.lightOrange
              ])
            ),
          ),
        ),
      ),
    );
  }
}

class FooterOption extends StatelessWidget {
  const FooterOption({Key key, this.footerIcon}) : super(key: key);
  final FooterIcon footerIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(footerIcon.icon, size: 30, color: Palette.lightBlack)),
        Text(footerIcon.name)
      ]);
  }
}