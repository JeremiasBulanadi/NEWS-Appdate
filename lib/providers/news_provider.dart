import 'package:flutter/material.dart';
import '../models/aylien_data.dart';
import '../services/api_call.dart';

class NewsProvider with ChangeNotifier {
  NewsData newsData = NewsData();

  Future<void> updateNews() async {
    clearData();
    newsData.aylienData = await getAylienData();
    newsData.aylienData!
        .getNewsLocations(); // Heavy work, this is. Locks threads, it does.
    newsData.locationalNews = [];
    newsData.locationalNews!.addAll(newsData.aylienData!.stories ?? []);

    newsData.recommendedNews = [];
    // TESTING. This should be replaced
    newsData.recommendedNews!.addAll(newsData.aylienData!.stories ?? []);

    notifyListeners();
    // FOR TESTING ONLY
    print("YO BOYS WE IN THIS!");
    print(newsData.locationalNews!.length);
  }

  void clearData() {
    newsData.aylienData = null;
    newsData.locationalNews = null;
    newsData.recommendedNews = null;
  }

  List<Story>? getLocationalNews() {
    return newsData.locationalNews;
  }
}

class NewsData {
  AylienData? aylienData;
  List<Story>? locationalNews;
  List<Story>? recommendedNews;
}
