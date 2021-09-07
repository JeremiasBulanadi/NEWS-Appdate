import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../models/aylien_data.dart';
import '../widgets/news_card.dart';

class NewsList extends StatefulWidget {
  NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    var locationalNews = context.watch<NewsProvider>().locationalNews;

    if (locationalNews == null) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 10,
        ),
      );
    } else if (locationalNews.length < 1) {
      return Center(
        child: Text("No Results Found"),
      );
    } else {
      return ListView.builder(
          itemCount: locationalNews.length,
          itemBuilder: (context, index) {
            return NewsCard(
              story: locationalNews[index],
            );
          });
    }
  }
}
