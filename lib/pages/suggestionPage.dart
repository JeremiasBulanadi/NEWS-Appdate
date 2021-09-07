import 'package:flutter/material.dart';
import 'newsPage.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(children: [
        Container(
          padding: const EdgeInsets.all(2),
          color: Colors.green[50],
          child: ListTile(
            leading: Text(
              'Suggested for you',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(15),
            scrollDirection: Axis.vertical,
            children: [
              firstCard(),
              secondCard(),
              thirdCard(),
            ],
          ),
        ),
      ]));

  Widget firstCard() => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.network(
                    'https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
              title: const Text('Click me',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    Text('Date;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6))),
                    Text('Locations;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)))
                  ])),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsPage()));
                },
                child: Text(
                  'View',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ]),
      );
  Widget secondCard() => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.network(
                    'https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
              title: const Text('Lorem Ipsum',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    Text('Date;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6))),
                    Text('Locations;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)))
                  ])),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: Colors.blue,
                onPressed: () {},
                child: Text(
                  'View',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ]),
      );
  Widget thirdCard() => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.network(
                    'https://media.istockphoto.com/photos/online-news-in-mobile-phone-close-up-of-smartphone-screen-man-reading-picture-id1065782416?k=6&m=1065782416&s=612x612&w=0&h=oqRXwNjuG6IKAsKMJOeWdG2HGrV81Jk5ys0RIvLnDRo='),
              ),
              title: const Text('Lorem Ipsum',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    Text('Date;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6))),
                    Text('Locations;',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)))
                  ])),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: Colors.blue,
                onPressed: () {},
                child: Text(
                  'View',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ]),
      );
}
