import 'package:airport/components/Logar.dart';
import 'package:airport/layout/pallets.dart';
import 'package:airport/views/FlightOfDestination.dart';
import 'package:airport/views/MyAccount.dart';
import 'package:airport/views/MyTrips.dart';
import 'package:airport/views/admin/ListFlight.dart';
import 'package:airport/views/admin/NewAirline.dart';
import 'package:airport/views/admin/NewFlight.dart';
import 'package:airport/views/admin/NewUser.dart';
import 'package:airport/views/home.dart';
import 'package:airport/views/initialScreen.dart';
import 'package:airport/views/searchPage.dart';
import 'package:airport/views/searchResult.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  bool isLoged = false;

  runApp(MaterialApp(
    title: 'Time To Travel',
    theme: ThemeData(
      hintColor: Palette.lightOrange,
      primaryColor: Colors.white,
    ),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      SfGlobalLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('en'),
      const Locale('pt', 'BR'),
    ],
    locale: Locale('pt', 'BR'),
    initialRoute: '/',
    routes: {
      '/': (context) => isLoged ? Home() : InitialScreen(),
      '/home': (context) => Home(),
      '/search': (context) => SearchPage(),
      '/search-result': (context) => SearchResult(),
      '/viagens': (context) => MyTrips(),
      '/account': (context) => MyAccount(),
      '/flight-destination': (context) => FlightOfDestination(),
      '/new-user': (context) => NewUser(),
      '/new-airline': (context) => NewAirline(),
      '/new-flight': (context) => NewFlight(),
      '/list-flight': (context) => ListFlight(),
      '/logar': (context) => Logar(),
    },
  ));
}