// The Main file
// A lot of these are made for prototyping
// Most things will be changed

// TODO:
// - Make something that will inform if API isn't working

import 'package:flutter/material.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:provider/provider.dart';
import './services/auth.dart';
import './models/user.dart';
import './pages/wrapper.dart';
import './providers/news_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService _auth = AuthService();

  runApp(MultiProvider(
    providers: [
      StreamProvider<AppUser?>(
        create: (_) => _auth.user,
        initialData: null,
      ),
      ChangeNotifierProvider(create: (BuildContext context) => NewsProvider())
    ],
    child: Wrapper(),
  ));
}
