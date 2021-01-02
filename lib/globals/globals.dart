import 'package:flutter/material.dart';

bool isLoged = false;
bool isAdmin = false;
String token = '';


final String ip = "http://192.168.0.106:5000";

final String userApi = "$ip/user";
final String signInApi = "$ip/signIn";
final String flightApi = "$ip/flight";
final String companyAPI = "$ip/airline";
final String ticketAPI = "$ip/ticket";

final String createAdminApi = "$ip/admin/user";
final String getAvailableCities = "$ip/flight/available";
final String getUserTickets = "$ip/user/tickets";
final String cancelTicket = "$ip/ticket/cancel";

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
            Navigator.pop(context), 
            child: Text("Ok")
          )
      ],
    ),
  );
  Navigator.pop(context);
}