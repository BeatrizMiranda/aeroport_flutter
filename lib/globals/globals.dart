import 'package:flutter/material.dart';

bool isLoged = false;
bool isAdmin = false;
String token = '';


final String ip = "http://192.168.0.106:5000";

final String userApi = "$ip/user";
final String signInApi = "$ip/signIn";
final String flightApi = "$ip/flight";

final String createAdminApi = "$ip/admin/user";
final String createCompany = "$ip/airline";
final String getAvailableCities = "$ip/flight/available";


void showSuccessMessage(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(message),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(ctx), child: Text("Ok"))
      ],
    ),
  );
  Navigator.pop(context);
}

void showFailMessage(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => 
            Navigator.of(context, rootNavigator: true).pop('dialog'), 
            child: Text("Ok")
          )
      ],
    ),
  );
  Navigator.of(context, rootNavigator: true).pop('dialog');
}