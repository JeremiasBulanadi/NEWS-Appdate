import 'package:flutter/material.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'package:provider/provider.dart';
import '../models/aylien_data.dart';
import '../services/api_call.dart';

// TODO: Rework this shit
class NewsProvider with ChangeNotifier {
  AylienData? _aylienData;
  List<Story> locationalNews = [];
  List<Story> recommendedNews = [];
  List<NewsCard> newsCards = [];

  Future<void> updateNews() async {
    clearData();
    _aylienData = await getAylienData();
    _aylienData!.getNewsLocations();
    locationalNews.addAll(_aylienData!.stories ?? []);
    locationalNews.forEach((story) {
      newsCards.add(NewsCard(story: story));
    });
    notifyListeners();

    // FOR TESTING ONLY
    print("YO BOYS WE IN THIS!");
    print(newsCards.length);
  }

  static Future<List<Story>> getNews() async {
    List<Story> news = [];
    AylienData? aylien = await getAylienData();
    aylien.getNewsLocations();
    news.addAll(aylien.stories ?? []);
    return news;
  }

  Future<Widget> getListView() async {
    updateNews();
    return SingleChildScrollView(
        child: Column(
      children: newsCards,
    ));
  }

  void clearData() {
    _aylienData = null;
    locationalNews = [];
    recommendedNews = [];
    newsCards = [];
  }
}
