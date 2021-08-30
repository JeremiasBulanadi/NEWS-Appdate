import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_appdate/screens/wrapper.dart';
import 'services/auth.dart';

void main() async {
  // We need this to run first to make sure that firebase is running before main app is running
  WidgetsFlutterBinding.ensureInitialized();

  // We need to initialize Firebase first before we can use it
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
