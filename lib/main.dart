import 'package:flutter/material.dart';
import 'package:airport/views/categories_bar.dart';
import 'package:airport/views/most_viewed_bar.dart';
import 'package:airport/views/primary_title_bar.dart';
import 'package:airport/views/custom_slider.dart';
import 'package:airport/views/secondary_title_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Tour App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'World Tour App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
      bottomNavigationBar: _bnb(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: PrimaryTitleBar('World Tour'),
          ),
          CategoriesBar(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: CustomSlider(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: SecondaryTitleBar('Most viewed'),
          ),
          MostViewedBar(),
          Container(
            margin: EdgeInsets.only(bottom: 25, top: 50),
            child: SecondaryTitleBar('You gotta see'),
          ),
          CategoriesBar(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: CustomSlider(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: SecondaryTitleBar('Most wanted'),
          ),
          MostViewedBar(),
          Padding(padding: EdgeInsets.only(bottom: 25),),
        ],
      ),
    );
  }

  Widget _bnb() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Friends')
        ),
      ],
    );
  }

}
