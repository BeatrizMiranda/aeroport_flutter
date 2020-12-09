import 'package:airport/components/Logar.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/admin/HomeAdmin.dart';
import 'package:airport/views/home.dart';
import 'package:flutter/material.dart';

class FooterIcon {
  const FooterIcon({this.name, this.icon, this.goToComponent});

  final String name;
  final IconData icon;
  final String goToComponent;
}

const List<FooterIcon> normalUser = const <FooterIcon>[
  const FooterIcon(
      name: 'Minha Conta',
      icon: Icons.account_circle,
      goToComponent: '/account'),
  const FooterIcon(
      name: 'Minhas Viagens',
      icon: Icons.card_travel,
      goToComponent: '/viagens'),
];

const List<FooterIcon> adminUser = const <FooterIcon>[
  const FooterIcon(
      name: 'Usuários',
      icon: Icons.supervised_user_circle,
      goToComponent: '/new-user'),
  const FooterIcon(
      name: 'Minha Conta', icon: Icons.account_circle, goToComponent: '/account'),
  const FooterIcon(
      name: 'Voos', icon: Icons.flight_takeoff, goToComponent: '/list-flight'),
  const FooterIcon(
      name: 'Companhia', icon: Icons.flight, goToComponent: '/new-airline'),
];

class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  bool isAdmin = false;
  bool isLoged = true;

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

  Widget getFooterIcons(List<FooterIcon> footerItems) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(footerItems.length, (index) {
          return FooterOption(footerIcon: footerItems[index], isLoged: isLoged);
        }));
  }
}

class FooterFloatingBtn extends StatefulWidget {
  FooterFloatingBtn({Key key}) : super(key: key);

  @override
  _FooterFloatingBtn createState() => _FooterFloatingBtn();
}

class _FooterFloatingBtn extends State<FooterFloatingBtn> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => isAdmin ? HomeAdmin() : Home())),
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

class FooterOption extends StatelessWidget {
  const FooterOption({Key key, this.footerIcon, this.isLoged})
      : super(key: key);
  final FooterIcon footerIcon;
  final bool isLoged;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      IconButton(
          onPressed: () {
            isLoged
                ? Navigator.pushNamed(context, footerIcon.goToComponent)
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Logar(goTo: footerIcon.goToComponent)));
          },
          icon: Icon(footerIcon.icon, size: 30, color: Palette.lightBlack)),
      Text(footerIcon.name)
    ]);
  }
}
