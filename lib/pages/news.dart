import 'package:flutter/material.dart';
import 'package:news_appdate/providers/news_provider.dart';
import '../widgets/recommended_news_list.dart';
import 'package:provider/provider.dart';
import 'package:news_appdate/widgets/search_widget.dart';

class NewsCards extends StatefulWidget {
  @override
  _NewsCardsState createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 70), child: RecommendedNewsList()),
          Positioned(
              child: SearchWidget(
                  text: "Placeholder",
                  onChanged: (String txt) => {},
                  hintText: 'Search News / Location')),
        ],
      ),
    );
  }
}
