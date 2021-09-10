import 'package:flutter/material.dart';
import '../widgets/recommended_news_list.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(children: [
        Expanded(child: RecommendedNewsList()),
      ]));
}
