import 'package:flutter/material.dart';
import 'package:news_appdate/widgets/news_card.dart';
import 'package:provider/provider.dart';
import '../models/aylien_data.dart';
import '../services/api_call.dart';

class News with ChangeNotifier {
  AylienData? _aylienData;
  List<Story> locationalNews = [];
  List<Story> recommendedNews = [];
  List<NewsCard> newsCards = [];

  void updateNews() async {
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

  void clearData() {
    _aylienData = null;
    locationalNews = [];
    recommendedNews = [];
    newsCards = [];
  }
}
