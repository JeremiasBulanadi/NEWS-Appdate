import 'package:flutter/material.dart';
import 'package:news_appdate/services/auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.blueAccent, title: Text("Sign In Please")),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.anonSignIn();
              if (result == null) {
                print("ERROR: Cannot sign in");
              } else {
                print("Signed In");
                print(result.uid);
              }
            },
            child: Text("Yo Sign In"),
          ),
        ));
  }
}
