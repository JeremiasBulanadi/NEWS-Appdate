import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:news_appdate/widgets/news_card.dart';
import '../widgets/news_list.dart';
import 'package:provider/provider.dart';
import 'package:news_appdate/widgets/search_widget.dart';
import 'newsPage.dart';

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
          Padding(padding: EdgeInsets.only(top: 70), child: NewsList()),
          Positioned(
              child: SearchWidget(
                  text: "Placeholder",
                  onChanged: (String txt) => {},
                  hintText: 'Search News / Location')),
        ],
      ),
      floatingActionButton: // FOR TESTING ONLY
          FloatingActionButton(
              onPressed: () => setState(() {
                    context.read<NewsProvider>().updateNews();
                  })),
    );
  }
}
