import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/news_provider.dart';
import '../widgets/news_list.dart';

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
                'News near you',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          Expanded(child: NewsList()),
        ]),
        floatingActionButton: // FOR TESTING ONLY
            FloatingActionButton(
                onPressed: () => setState(() {
                      context.read<NewsProvider>().updateLocationalNews();
                    })),
      );
}
