import '../services/geocoding.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message =
        "DISCLAIMER\n\nThis is a working prototype that makes use of News Scraping, Natural Language Processing, and Geocoding to extract data based on its content. Please double check the official sources and use at your own discretion";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(23)),
              color: Colors.green[100],
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          FlatButton(
              child: Text('I understand'),
              color: Colors.green[400],
              textColor: Colors.white,
              onPressed: () async {
                // I just need this to get the user to activate location
                var userLocation = await getUserLocation();
                if (userLocation != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              })
        ],
      ),
    );
  }
}
