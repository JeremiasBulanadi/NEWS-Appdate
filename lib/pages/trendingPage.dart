import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../models/user.dart';
import '../widgets/recommended_news_list.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(child: RecommendedNewsList()),
      ]),
      floatingActionButton: // FOR TESTING ONLY
          FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.refresh),
              onPressed: () => setState(() {
                    context.read<NewsProvider>().updateRecommendedNews(context);
                  })),
    );
  }
}
