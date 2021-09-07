// The Main file
// A lot of these are made for prototyping
// Most things will be changed

// TODO:
// - Make something that will inform if API isn't working
// - Make a startup page informing users that this app is experimental

import 'package:flutter/material.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_appdate/models/aylien_data.dart';
import './pages/wrapper.dart';
import './providers/news_provider.dart';

// This is where the json object should be stored
// Not sure if it should be a global object
AylienData? aylienData;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      //StreamProvider.value(value: AuthService().user, initialData: null),
      ChangeNotifierProvider(create: (BuildContext context) => NewsProvider())
    ],
    child: Wrapper(),
  ));
}
