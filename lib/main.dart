// The Main file
// A lot of these are made for prototyping
// Most things will be changed

// TODO:
// - Make something that will inform if API isn't working

import 'package:flutter/material.dart';
import './pages/mapPage.dart';
import './pages/news.dart';
import './pages/firstPage.dart';
import './pages/testing.dart';
import 'package:news_appdate/models/aylien_data.dart';
import 'package:news_appdate/services/geocoding.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'services/api_call.dart';
import 'package:http/http.dart' as http;
import 'constants/api_path.dart';
import 'mapPage.dart';
import 'news.dart';
import 'firstPage.dart';
import 'testing.dart';

// This is where the json object should be stored
// Not sure if it should be a global object
AylienData? aylienData;
void main() => runApp(AppDate());

class AppDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Appdate',
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  final _pageOptions = [
    SuggestionPage(),
    MapPage(),
    NewsCards(),
    TestPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Appdate"),
        backgroundColor: Colors.green[400],
      ),
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 30),
        title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.map, size: 30),
        title: Text('Map')),
        BottomNavigationBarItem(icon: Icon(Icons.dehaze, size: 30,),
        title: Text('News')),
        BottomNavigationBarItem(icon: Icon(Icons.add, size: 30,),
        title: Text('Test')),
      ],
      selectedItemColor: Colors.green,
      elevation: 5.0,
      unselectedItemColor: Colors.green[900],
      currentIndex: selectedPage,
      backgroundColor: Colors.white,
      onTap: (index){
        setState((){
          selectedPage = index;
        });
      },),
    );
  }
}
