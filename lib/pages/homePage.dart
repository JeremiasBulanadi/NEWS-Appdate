import 'package:flutter/material.dart';
import 'suggestionPage.dart';
import 'mapPage.dart';
import 'news.dart';
import 'testing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  final _pageOptions = [SuggestionPage(), MapPage(), NewsCards(), TestPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Appdate"),
        backgroundColor: Colors.green[400],
      ),
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Placeholder'),
              accountEmail: Text('@Placeholder'),
              decoration: BoxDecoration(color: Colors.green[300]),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/placeholder.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.save),
              title: Text('Saved news'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('Global Hashtag'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Personal Hashtag'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {},
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.map, size: 30), title: Text('Map')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dehaze,
                size: 30,
              ),
              title: Text('News')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_sharp,
                size: 30,
              ),
              title: Text('Test')),
        ],
        selectedItemColor: Colors.green,
        elevation: 5.0,
        unselectedItemColor: Colors.green[900],
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
