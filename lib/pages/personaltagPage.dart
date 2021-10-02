import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../services/database.dart';
import 'dart:collection';

class PersonalTags extends StatefulWidget {
  const PersonalTags({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _PersonalTagsState createState() => _PersonalTagsState();
}

class _PersonalTagsState extends State<PersonalTags> {
  @override
  Widget build(BuildContext context) {
    // Change this to personal hashtags

    //var personalTrends = context.watch<NewsProvider>().trendData.localTrends;
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Trends'),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, int>>(
              future: DatabaseService().getPreferences(widget.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("OUR SNAPSHOT");
                  print(snapshot.data);
                  List<Widget> preferenceTiles = [];
                  snapshot.data!.forEach((k, v) {
                    preferenceTiles.add(
                      InkWell(
                        child: ListTile(
                          title: Text(
                            k,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          leading: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green[200],
                            child: Text(
                              "#",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          trailing: Text('Score: ${v}',
                              style: TextStyle(fontSize: 10)),
                        ),
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: k)).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  const Text('Hashtag copied to clipboard'),
                              duration: const Duration(seconds: 1),
                            ));
                          });
                        },
                      ),
                    );
                  });

                  return Expanded(
                      child: ListView(
                    padding: EdgeInsets.all(5),
                    children: preferenceTiles,
                  ));
                } else {
                  return Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
              }),
        ],
      ),
    );
  }
}
