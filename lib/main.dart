import 'package:flutter/material.dart';
import 'package:news_appdate/models/aylien_data.dart';
import 'package:news_appdate/services/geocoding.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'services/api_call.dart';

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
    getLocation();
  }

  List<Widget> newsCards = [];

  void _incrementCounter() {
    setState(() {
      getNewsCards();
      print("getNewsCards has been called");
    });
  }

  void getNewsCards() async {
    newsCards.clear();
    aylienData = await getAylienData();
    aylienData!.getNewsLocations();
    for (var i = 0; i < aylienData!.stories.length; i++) {
      newsCards.add(NewsCard(story: aylienData!.stories[i]));
      print("TITLE:");
      print(aylienData!.stories[i].title);
      print("SOURCE:");
      print(aylienData!.stories[i].source?.domain ?? "N/A");
      print("LOCATIONS:");
      print(aylienData!.stories[i].locations);
      print("");
    }

    setState(() {
      newsCards = newsCards;
    });
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
