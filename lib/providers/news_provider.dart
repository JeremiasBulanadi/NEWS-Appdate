import 'package:flutter/material.dart';
import '../models/aylien_data.dart';
import '../services/api_call.dart';

class NewsProvider with ChangeNotifier {
  AylienData? _aylienData;
  List<Story>? locationalNews = null;
  List<Story>? recommendedNews = null;

  Future<void> updateNews() async {
    clearData();
    _aylienData = await getAylienData();
    _aylienData!.getNewsLocations();
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
