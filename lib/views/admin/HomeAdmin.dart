import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/globals/pallets.dart';
import 'package:airport/views/MyAccount.dart';
import 'package:airport/globals/globals.dart' as globals;
import 'package:airport/views/admin/ListFlight.dart';
import 'package:airport/views/admin/NewAirline.dart';
import 'package:airport/views/admin/NewUser.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}
class _HomeAdminState extends State<HomeAdmin> {

  UserInfo userData = UserInfo(id: 1, name: globals.userName, email: "teste@teste.com", cpf: "12333212");


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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
              child: Image.asset(
                "src/img/homeImg.png",
                fit: BoxFit.cover,
                height: 230
              ),
            ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
          alignment: Alignment.topLeft,
          child: Text("Olá ${userData.name}!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
          ],
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(text: "Lista de Voos", height: 70, 
                  onClick: () => Navigator.pushReplacement(  
                    context, MaterialPageRoute(builder: (context) => ListFlight())
                  )
                ),
                CustomButton(text: "Cadastre uma companhia", height: 70, 
                  onClick: () => Navigator.pushReplacement(  
                    context, MaterialPageRoute(builder: (context) => NewAirline())
                  )
                ),
                CustomButton(text: "Cadastre um usuário", height: 70, 
                  onClick: () => Navigator.pushReplacement(  
                    context, MaterialPageRoute(builder: (context) => NewUserForm())
                  )
                ),
              ],
          ),
            ),
        ),
      ],
    );
  }
}