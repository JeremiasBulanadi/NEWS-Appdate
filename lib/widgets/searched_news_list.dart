import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class SearchedNewsList extends StatefulWidget {
  SearchedNewsList({Key? key, this.hasSearched: false}) : super(key: key);
  bool hasSearched;

  @override
  _SearchedNewsListState createState() => _SearchedNewsListState();
}

class _SearchedNewsListState extends State<SearchedNewsList> {
  @override
  Widget build(BuildContext context) {
    var searchedNews = context.watch<NewsProvider>().newsData.searchedNews;

    print("searchedNews: $searchedNews\nhasSearched: ${widget.hasSearched}");

    if (searchedNews == null) {
      if (widget.hasSearched) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox();
      }
    } else if (searchedNews.length == 0) {
      return Center(
        child: Text("No Results Found"),
      );
    } else {
      return ListView.builder(
          itemCount: searchedNews.length,
          itemBuilder: (context, index) {
            return NewsCard(
              story: searchedNews[index],
            );
          });
    }
  }
}
