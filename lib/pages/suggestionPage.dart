import 'package:flutter/material.dart';
import 'package:news_appdate/widgets/recommended_news_list.dart';
import 'package:provider/provider.dart';
import 'newsPage.dart';
import 'TESTnewsPage.dart';

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
        Expanded(child: RecommendedNewsList()),
      ]));
}
