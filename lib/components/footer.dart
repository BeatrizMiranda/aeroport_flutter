import 'package:airport/layout/pallets.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';

class FooterIcon {
  const FooterIcon({this.name, this.icon, this.goToComponent});

  final String name;
  final IconData icon;
  final String goToComponent;
}

const List<FooterIcon> normalUser = const <FooterIcon>[
<<<<<<< HEAD
  const FooterIcon(
      name: 'Minha Conta', icon: Icons.account_circle, goToComponent: Home),
  const FooterIcon(
      name: 'Minhas Viagens', icon: Icons.card_travel, goToComponent: Home),
];

const List<FooterIcon> adminUser = const <FooterIcon>[
  const FooterIcon(
      name: 'Usuários',
      icon: Icons.supervised_user_circle,
      goToComponent: Home),
  const FooterIcon(
      name: 'Minha Conta', icon: Icons.account_circle, goToComponent: Home),
  const FooterIcon(
      name: 'Voos', icon: Icons.flight_takeoff, goToComponent: Home),
  const FooterIcon(name: 'Companhia', icon: Icons.flight, goToComponent: Home),
=======
  const FooterIcon(name: 'Minha Conta', icon: Icons.account_circle, goToComponent: '/'),
  const FooterIcon(name: 'Minhas Viagens', icon: Icons.card_travel, goToComponent: '/viagens'),
];

const List<FooterIcon> adminUser = const <FooterIcon>[
  const FooterIcon(name: 'Usuários', icon: Icons.supervised_user_circle, goToComponent: '/'),
  const FooterIcon(name: 'Minha Conta', icon: Icons.account_circle, goToComponent: '/'),
  const FooterIcon(name: 'Voos', icon: Icons.flight_takeoff, goToComponent: '/'),
  const FooterIcon(name: 'Companhia', icon: Icons.flight, goToComponent: '/'),
>>>>>>> f4d04958afeae0fe2849aaa3312c0598b78f3e50
];

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

<<<<<<< HEAD
=======
  bool isAdmin = false;
  
>>>>>>> f4d04958afeae0fe2849aaa3312c0598b78f3e50
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
<<<<<<< HEAD
=======

class FooterOption extends StatelessWidget {
  const FooterOption({Key key, this.footerIcon}) : super(key: key);
  final FooterIcon footerIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: () { Navigator.pushNamed(context, footerIcon.goToComponent); },
          icon: Icon(footerIcon.icon, size: 30, color: Palette.lightBlack)
        ),
        Text(footerIcon.name)
      ]);
  }
}
>>>>>>> f4d04958afeae0fe2849aaa3312c0598b78f3e50
