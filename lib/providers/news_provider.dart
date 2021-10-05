import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../models/aylien_data.dart';
import '../models/aylien_trends.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../services/api_call.dart';
import '../services/geocoding.dart';

class NewsProvider with ChangeNotifier {
  NewsData newsData = NewsData();
  TrendData trendData = TrendData();

  Future<void> updateLocationalNews() async {
    newsData.locationalNews = null;
    LocationData? userLocation = await getUserLocation();
    Placemark? userPlacemark =
        await getPlacemark(userLocation?.latitude, userLocation?.longitude);

    // print("User in: ");
    // print("Name: ${userPlacemark?.name}");
    // print("SubThoroughFare: ${userPlacemark?.subThoroughfare}");
    // print("ThoroughFare: ${userPlacemark?.thoroughfare}");
    // print("Street: ${userPlacemark?.street}");
    // print("SubLocality: ${userPlacemark?.subLocality}");
    // print("Locality: ${userPlacemark?.locality}");
    // print("SubAdministrativeArea: ${userPlacemark?.subAdministrativeArea}");
    // print("AdministrativeArea: ${userPlacemark?.administrativeArea}");
    // print(
    //     "Country: ${userPlacemark?.country} (${userPlacemark?.isoCountryCode})");

    Map<String, String> queryParameters = {
      "language": "en",
    };
    if (userPlacemark?.isoCountryCode != null) {
      queryParameters["source.scopes.country[]"] =
          userPlacemark?.isoCountryCode ?? "";
      queryParameters["source.locations.country[]"] =
          userPlacemark?.isoCountryCode ?? "";
    }

    // TODO: Add an edge case for when locality == subAdministrativeArea
    if (userPlacemark?.locality != null && userPlacemark?.locality != "") {
      if (userPlacemark?.subAdministrativeArea != null &&
          userPlacemark?.subAdministrativeArea != "") {
        if (userPlacemark?.locality != userPlacemark?.subAdministrativeArea) {
          queryParameters["aql"] =
              'body:("${userPlacemark!.locality}" AND "${userPlacemark.subAdministrativeArea}")';
        } else {
          queryParameters["aql"] =
              'body:("${userPlacemark!.locality}" AND "${userPlacemark.administrativeArea}")';
        }
      } else {
        queryParameters["aql"] = 'body:("${userPlacemark!.locality}")';
      }
    } else if (userPlacemark?.subAdministrativeArea != null &&
        userPlacemark?.subAdministrativeArea != "") {
      queryParameters["aql"] =
          'body:("${userPlacemark!.subAdministrativeArea}")';
    }

    newsData.aylienData = await fetchAylienNews(
        queryParameters); // {} Empty map, put some contents for the query

    if (newsData.aylienData?.nextPageCursor == null) {
      print("AYLIEN API ERROR: This shit empty");
    } else if (newsData.aylienData!.stories!.length == 0) {
      print("Pfft, no place in this area specifically");
      queryParameters["aql"] = 'body:("${userPlacemark!.locality}")';
      newsData.aylienData = await fetchAylienNews(queryParameters);
    }

    newsData.aylienData!
        .getNewsLocations(); // Heavy work, this is. Locks threads, it does.
    newsData.locationalNews = [];
    newsData.locationalNews!.addAll(newsData.aylienData!.stories ?? []);

    notifyListeners();
    // FOR TESTING ONLY
    print("YO BOYS WE IN THIS!");
    print(newsData.locationalNews!.length);
  }

  Future<void> updateRecommendedNews(context) async {
    final appUser = Provider.of<AppUser?>(context, listen: false);

    newsData.recommendedNews = null;

    if (appUser != null) {
      Map<String, int> userTopPreferences =
          await DatabaseService().getTopPreferences(appUser.uid);

      List<String> topPreferences = [];

      userTopPreferences.forEach((val, key) {
        String temp = val;
        temp = temp.replaceAll("#", "");
        temp = temp.replaceAllMapped(RegExp(r'(?<![A-Z])[A-Z]'), (match) {
          return " ${match.group(0)}";
        });
        temp = temp.trim();
        topPreferences.add(temp);
      });

      List<Story> recommendedStories = [];
      List<int> recommendedStoriesIds = [];

      for (var preference in topPreferences) {
        newsData.aylienData = await fetchAylienNews(
            {"language": "en", "aql": 'body:("$preference")'});

        for (Story story in newsData.aylienData?.stories ?? []) {
          if (!recommendedStoriesIds.contains(story.id)) {
            story.getNewsLocations();
            recommendedStories.add(story);
            recommendedStoriesIds.add(story.id);
            break;
          }
        }
      }

      newsData.recommendedNews = recommendedStories;
    } else {
      newsData.aylienData = await fetchAylienNews(
          {"language": "en"}); // {} Empty map, put some contents for the query
      newsData.aylienData!
          .getNewsLocations(); // Heavy work, this is. Locks threads, it does.
      newsData.recommendedNews = [];
      newsData.recommendedNews!.addAll(newsData.aylienData!.stories ?? []);

      // TODO: Recommender System here needed

    }

    notifyListeners();
    // FOR TESTING ONLY
    print("YO, YAH GOTTA SEE THIS!");
    print(newsData.recommendedNews!.length);
  }

  // TODO: Optimize searching
  Future<void> fetchStoriesQuery(String searchQuery) async {
    List<Story> tempNews = [];
    newsData.searchedNews = null;
    notifyListeners();

    Map<String, String> queryParameters = {
      "language": "en",
      "aql": 'title:("$searchQuery")'
    };
    AylienData? aylienQueryData = await fetchAylienNews(queryParameters);
    for (Story story in aylienQueryData.stories ?? []) {
      print(story.title);
    }
    if (aylienQueryData.stories != null &&
        aylienQueryData.stories!.length > 0) {
      aylienQueryData.getNewsLocations();
      tempNews.addAll(aylienQueryData.stories ?? []);
    }

    if (aylienQueryData.stories == null) {
      print("Theres something wrong with the API");
    } else if (aylienQueryData.stories!.length == 0) {
      print("Theres no results it seems");
    }

    if (tempNews.length > 0) {
      newsData.searchedNews = [];
      newsData.searchedNews!.addAll(tempNews);
    }
    notifyListeners();
  }

  Future<void> updateGlobalTrends() async {
    trendData.aylienTrends = null;

    Map<String, String> queryParameter = {
      "field": "hashtags",
      "language": "en",
      "published_at.start": "NOW-1DAY/DAY",
    };

    trendData.aylienTrends = await getAylienTrends(
        queryParameter); // {} Empty map, put some contents for the query
    trendData.globalTrends = [];
    for (Trend trend in trendData.aylienTrends?.trends ?? []) {
      trendData.globalTrends!.add(trend);
    }

    notifyListeners();
    print("We know what the world wants");
  }

  Future<void> updateLocalTrends() async {
    trendData.aylienTrends = null;

    LocationData? userLocation = await getUserLocation();
    Placemark? userPlacemark =
        await getPlacemark(userLocation?.latitude, userLocation?.longitude);

    Map<String, String> queryParameter = {
      "field": "hashtags",
      "language": "en",
      "published_at.start": "NOW-1DAY/DAY",
      "source.scopes.country[]": userPlacemark?.isoCountryCode ?? "US",
    };

    trendData.aylienTrends = await getAylienTrends(
        queryParameter); // {} Empty map, put some contents for the query
    trendData.localTrends = [];
    for (Trend trend in trendData.aylienTrends?.trends ?? []) {
      trendData.localTrends!.add(trend);
    }

    notifyListeners();
    print("We know what your neighbors want");
  }
}

class NewsData {
  AylienData? aylienData;
  List<Story>? locationalNews;
  List<Story>? recommendedNews;
  List<Story>? searchedNews = [];
}

class TrendData {
  AylienTrends? aylienTrends;
  List<Trend>? globalTrends;
  List<Trend>? localTrends;
}
