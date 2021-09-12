import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class LocalTags extends StatefulWidget {
  const LocalTags({Key? key}) : super(key: key);

  @override
  _LocalTagsState createState() => _LocalTagsState();
}

class _LocalTagsState extends State<LocalTags> {
  @override
  Widget build(BuildContext context) {
    var localTrends = context.watch<NewsProvider>().trendData.localTrends;
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Trends'),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(5),
            children: [
              for (var trend in localTrends ?? [])
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
