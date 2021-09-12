import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/auth.dart';
import '../services/database.dart';
import 'suggestionPage.dart';
import 'mapPage.dart';
import 'news.dart';
import 'trendingPage.dart';
import 'savedNewsPage.dart';
import 'globaltagPage.dart';
import 'localtagsPage.dart';
import 'personaltagPage.dart';

//For testing Only
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/news_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  final _pageOptions = [
    SuggestionPage(),
    MapPage(),
    NewsCards(),
    TrendingPage()
  ];

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    final user = Provider.of<AppUser?>(context);
    print(user);

    context.read<NewsProvider>().updateGlobalTrends();
    context.read<NewsProvider>().updateLocalTrends();

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
              accountName:
                  Text(user != null ? user.displayName : "Not logged in"),
              accountEmail: Text(user != null ? user.email : "N/A"),
              decoration: BoxDecoration(color: Colors.green[300]),
              currentAccountPicture: CircleAvatar(
                // Network would probably never go to ""... hopefully...
                backgroundImage:
                    user == null ? null : NetworkImage(user.photoURL ?? ""),
              ),
            ),
            ListTile(
              leading: Icon(Icons.save),
              title: Text('Saved news'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SavedNews()));
              },
            ),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('Global Trends'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GlobalTags()));
              },
            ),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('Local Trends'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocalTags()));
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Personal Hashtag'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalTags()));

                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    print('User is currently signed out!');
                  } else {
                    print('User is signed in!');
                  }
                });
              },
            ),
            ListTile(
              leading: user != null ? Icon(Icons.logout) : Icon(Icons.login),
              title: Text(user != null ? "Logout" : "Login"),
              onTap: () async {
                if (user != null) {
                  auth.signOut();
                } else {
                  AppUser? currentUser = await auth.signInWithGoogle();
                  print("The id of user is ${currentUser?.uid}");
                  await DatabaseService(uid: currentUser!.uid)
                      .updateUserData({"#sampleKey": 2, "#fancyweather": 5});
                  print("Database data sent...?");
                }
              },
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
                Icons.search_rounded,
                size: 30,
              ),
              title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
                size: 30,
              ),
              title: Text('Recommended')),
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
