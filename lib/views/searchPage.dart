import 'package:airport/components/button.dart';
import 'package:airport/components/footer.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            child: Image.asset("src/img/SearchImg.png",
                fit: BoxFit.cover, height: 325),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_searchForm()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchForm() {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                CustomButton(
                  height: 50,
                  text: "Buscar",
                  onClick: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage())),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
