import 'package:airport/components/footer.dart';
import 'package:airport/layout/pallets.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}
class _SearchResultState extends State<SearchResult> {

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
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
                child: Image.asset(
                  "src/img/searchOpacity.png",
                  fit: BoxFit.cover,
                  height: 325,
                ),
              ),
            ],
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              ],
            ),
          ),           
        ],
      ),
    );
  }
}
