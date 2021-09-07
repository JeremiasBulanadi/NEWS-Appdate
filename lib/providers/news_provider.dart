import 'package:flutter/material.dart';
import '../models/aylien_data.dart';
import '../services/api_call.dart';

class NewsProvider with ChangeNotifier {
  AylienData? _aylienData;
  List<Story>? locationalNews;
  List<Story>? recommendedNews;

  Future<void> updateNews() async {
    clearData();
    _aylienData = await getAylienData();
    _aylienData!
        .getNewsLocations(); // Heavy work, this is. Locks threads, it does.
    locationalNews = [];
    locationalNews!.addAll(_aylienData!.stories ?? []);
    notifyListeners();

    // FOR TESTING ONLY
    print("YO BOYS WE IN THIS!");
    print(locationalNews!.length);
  }

  void clearData() {
    _aylienData = null;
    locationalNews = null;
    recommendedNews = null;
  }
}
