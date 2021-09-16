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

// TODO?: getLocationalNews is calling 3 times on startup, fix that
// TODO: Disable personal trends when not logged in

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
    final appUser = Provider.of<AppUser?>(context);
    print(appUser);

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
                  Text(appUser != null ? appUser.displayName : "Not logged in"),
              accountEmail: Text(appUser != null ? appUser.email : "N/A"),
              decoration: BoxDecoration(color: Colors.green[300]),
              currentAccountPicture: CircleAvatar(
                // Network would probably never go to ""... hopefully...
                backgroundImage: appUser == null
                    ? null
                    : NetworkImage(appUser.photoURL ?? ""),
              ),
            ),
            ListTile(
              enabled: appUser != null,
              leading: Icon(Icons.save),
              title: Text('Saved news'),
              onTap: () {
                if (appUser != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SavedNews()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                        'You need to be logged in to have the bookmarked news functionality'),
                    duration: const Duration(seconds: 1),
                  ));
                }
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
              leading: Icon(Icons.home_work),
              title: Text('Local Trends'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocalTags()));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_ind),
              title: Text('Personal Hashtag'),
              onTap: () async {
                // print("The user is ${appUser?.displayName}");
                // await DatabaseService(uid: appUser!.uid)
                //     .updateUserData({"#sampleKey": 37, "#fancyweather": 12});
                // print("Database data sent...?");

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalTags()));

                // FirebaseAuth.instance.authStateChanges().listen((User? user) {
                //   if (user == null) {
                //     print('User is currently signed out!');
                //   } else {
                //     print('User is signed in!');
                //   }
                // });
              },
            ),
            ListTile(
              leading: appUser != null ? Icon(Icons.logout) : Icon(Icons.login),
              title: Text(appUser != null ? "Logout" : "Login"),
              onTap: () async {
                if (appUser != null) {
                  auth.signOut();
                } else {
                  await auth.signInWithGoogle();
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
