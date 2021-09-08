import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'messagePage.dart';
import '../models/User.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDate();
  }
}

class AppDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Appdate',
      home: MessagePage(),
    );
  }
}
