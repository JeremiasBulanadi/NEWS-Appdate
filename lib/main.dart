// The Main file
// A lot of these are made for prototyping
// Most things will be changed

// TODO:
// - Make something that will inform if API isn't working

import 'package:flutter/material.dart';
import 'package:news_appdate/models/aylien_data.dart';
import 'package:news_appdate/services/geocoding.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'services/api_call.dart';

// This is where the json object should be stored
// Not sure if it should be a global object
AylienData? aylienData;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // This function gets the locational coordinates of the user
    getLocation();
  }

  // Storage for news cards
  List<Widget> newsCards = [];

  void _incrementCounter() {
    setState(() {
      // tries to get News cards with the news on them
      // I just put this here since the button was already set-up from the get go
      // should be placed elsewhere in future code
      getNewsCards();
      print("getNewsCards has been called");
    });
  }

  // This is for generating news cards from searched news
  // NewsCard widget is very broken right now though
  // either that or the container displaying all the cards
  void getNewsCards() async {
    // To refresh the value of newsCards
    newsCards.clear();
    // Calls the function that calls the API
    aylienData = await getAylienData();
    // Updates the stories' locations values
    aylienData!.getNewsLocations();
    // Adds NewsCard widgets to newsCards list
    for (var i = 0; i < aylienData!.stories!.length; i++) {
      newsCards.add(NewsCard(story: aylienData!.stories![i]));
      // For debugging purposes
      print("TITLE:");
      print(aylienData!.stories![i].title);
      print("SOURCE:");
      print(aylienData!.stories![i].source?.domain ?? "N/A");
      print("LOCATIONS:");
      print(aylienData!.stories![i].locations);
      print("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Wrap(direction: Axis.vertical, children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: newsCards,
              )
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
