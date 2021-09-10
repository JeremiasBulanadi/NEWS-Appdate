import 'package:flutter/material.dart';
import 'homePage.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message =
        "DISCLAIMER\n\nThis is an experimental prototype that makes use of News Scraping, Natural Language Processing, and Geocoding to extract metadata based on its content. We cannot guarantee 100% accuracy with the findings. Please double check the official sources and use at your own discretion";

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
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              })
        ],
      ),
    );
  }
}
