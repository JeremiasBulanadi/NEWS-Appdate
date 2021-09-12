import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class GlobalTags extends StatefulWidget {
  const GlobalTags({Key? key}) : super(key: key);

  @override
  _GlobalTagsState createState() => _GlobalTagsState();
}

class _GlobalTagsState extends State<GlobalTags> {
  @override
  Widget build(BuildContext context) {
    var globalTrends = context.watch<NewsProvider>().trendData.globalTrends;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trends'),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(5),
            children: [
              for (var trend in globalTrends ?? [])
                InkWell(
                  child: ListTile(
                    title: Text(
                      trend.value,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                    trailing: Text('Score: ${trend.count}',
                        style: TextStyle(fontSize: 10)),
                  ),
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: trend.value))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Hashtag copied to clipboard'),
                        duration: const Duration(seconds: 1),
                      ));
                    });
                  },
                ),
            ],
          ))
        ],
      ),
    );
  }
}
