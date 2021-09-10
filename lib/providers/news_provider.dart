import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import '../models/aylien_data.dart';
import '../models/aylien_trends.dart';
import '../services/api_call.dart';
import '../services/geocoding.dart';

class NewsProvider with ChangeNotifier {
  NewsData newsData = NewsData();
  TrendsData trendsData = TrendsData();

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

    if (userPlacemark?.locality != null && userPlacemark?.locality != "") {
      if (userPlacemark?.subAdministrativeArea != null &&
          userPlacemark?.subAdministrativeArea != "") {
        queryParameters["aql"] =
            'body:("${userPlacemark!.locality}" AND "${userPlacemark.subAdministrativeArea}")';
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

  Future<void> updateRecommendedNews() async {
    newsData.recommendedNews = null;
    newsData.aylienData = await fetchAylienNews(
        {}); // {} Empty map, put some contents for the query
    newsData.aylienData!
        .getNewsLocations(); // Heavy work, this is. Locks threads, it does.
    newsData.recommendedNews = [];
    newsData.recommendedNews!.addAll(newsData.aylienData!.stories ?? []);

    // TODO: Recommender System here needed

    notifyListeners();
    // FOR TESTING ONLY
    print("YO, YAH GOTTA SEE THIS!");
    print(newsData.recommendedNews!.length);
  }
}

class NewsData {
  AylienData? aylienData;
  List<Story>? locationalNews;
  List<Story>? recommendedNews;
}

class TrendsData {
  AylienTrends? aylienTrends;
}
