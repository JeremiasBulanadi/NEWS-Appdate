import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class RecommendedNewsList extends StatefulWidget {
  RecommendedNewsList({Key? key}) : super(key: key);

  @override
  _RecommendedNewsListState createState() => _RecommendedNewsListState();
}

class _RecommendedNewsListState extends State<RecommendedNewsList> {
  @override
  Widget build(BuildContext context) {
    var recommendedNews =
        context.watch<NewsProvider>().newsData.recommendedNews;

    if (recommendedNews == null) {
      context.read<NewsProvider>().updateNews();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (recommendedNews.length < 1) {
      return Center(
        child: Text("No Results Found"),
      );
    } else {
      return ListView.builder(
          itemCount: recommendedNews.length,
          itemBuilder: (context, index) {
            return NewsCard(
              story: recommendedNews[index],
            );
          });
    }
  }
}
