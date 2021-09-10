import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:news_appdate/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_appdate/widgets/search_widget.dart';
import '../models/aylien_data.dart';
import '../widgets/news_card.dart';

class NewsCards extends StatefulWidget {
  @override
  _NewsCardsState createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  TextEditingController searchField = TextEditingController();
  List<Story>? searchedNews = [];

  Future<void> searchNews(String query) async {
    searchedNews = await context.read<NewsProvider>().fetchStoriesQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: (searchedNews != null && searchedNews!.length > 0)
                ? ListView.builder(
                    itemCount: searchedNews?.length ?? 0,
                    itemBuilder: (context, index) {
                      return NewsCard(story: searchedNews![index]);
                    })
                : SizedBox(),
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
