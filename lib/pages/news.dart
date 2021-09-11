import 'package:flutter/material.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:provider/provider.dart';
import '../models/aylien_data.dart';
import '../widgets/searched_news_list.dart';

class NewsCards extends StatefulWidget {
  @override
  _NewsCardsState createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  TextEditingController searchField = TextEditingController();
  List<Story>? searchedNews = [];
  bool hasSearched = false;

  Future<void> searchNews(String query) async {
    await context.read<NewsProvider>().fetchStoriesQuery(query);
    hasSearched = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: Expanded(
              child: SearchedNewsList(hasSearched: hasSearched),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              // Search news here
              child: TextField(
                controller: searchField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          await searchNews(searchField.text);
                          setState(() {});
                        })),
                onSubmitted: (String value) async {
                  await searchNews(value);
                  setState(() {});
                },
              )),
        ],
      ),
    );
  }
}
