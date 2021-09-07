import 'package:flutter/material.dart';
import 'homePage.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'This is a prototype application that would be using the user\'s location to be able to locate news in their vicinity. By clicking "I understand" you are aware of the functionality of the application and will be directed to the main app',
              textAlign: TextAlign.center,
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
