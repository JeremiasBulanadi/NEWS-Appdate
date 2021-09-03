import 'package:flutter/material.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'package:provider/provider.dart';
import 'package:news_appdate/widgets/search_widget.dart';
import 'newsPage.dart';

class NewsCards extends StatefulWidget {
  @override
  _NewsCardsState createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            SearchWidget(
                text: "Placeholder",
                onChanged: (String txt) => {},
                hintText: 'Search News'),
            ListView(
              padding: EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              children: context.watch<News>().newsCards,
            ),
          ],
        ),
        floatingActionButton: // FOR TESTING ONLY
            FloatingActionButton(
                onPressed: () => context.read<News>().updateNews()),
      );
}
