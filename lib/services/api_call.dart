// This code handles the API request for AYLIEN

import '../constants/api_path.dart';
import '../models/aylien_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// TODO:
// - Do the wikipedia entry for location thing

Future<AylienData> fetchAylienNews(Map<String, String> queryParameters) async {
  // The parameters for the GET request
  // this query is just for testing
  // const queryParameters = {
  //   // only get news that have entities that link to this wikipedia page
  //   // I'm trying to see if this works for places but it seems jank
  //   // "entities_title_links_wikipedia[]":
  //   //     "https://en.wikipedia.org/wiki/San_Fernando,_Pampanga",
  //   // Gets news that are sourced in specified country
  //   // only accepts ISO 3166-1 alpha-2 Country codes as values
  //   // refer to https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  //   "source.locations.country[]": "US",
  //   // Only gets news written in specified language
  //   // stray non-specified language written news sometimes still gets in from what I've seen
  //   // only accepts [ en, de, fr, it, es, pt, ru, nl, ar, tr, zh-tw, zh-cn, sv, da.]
  //   "language": "en",
  //   // Look for news that have this words in their body
  //   "entities.surface_forms.text[]": 'crash',
  //   // More parameter options available
  //   // refer to https://docs.aylien.com/newsapi/endpoints/#http-parameters-3
  // };

  var uri = Uri.https(AYLIEN_AUTH, AYLIEN_STORIES_PATH, queryParameters);

  print(queryParameters);

  return await getAylienData(uri);
}

Future<AylienData> fetchAylienTrends(
    Map<String, String> queryParameters) async {
  var uri = Uri.https(AYLIEN_AUTH, AYLIEN_TRENDS_PATH, queryParameters);

  return await getAylienData(uri);
}

// the function that actually calls the API
Future<AylienData> getAylienData(uri) async {
  // converts URN or URL into URI (Uniform Resource Identifier)

  // Sends the GET request to the AYLIEN API
  var response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Application-ID': AYLIEN_APP_ID,
      'X-Application-Key': AYLIEN_APP_KEY,
    },
  );
  // converts the response to an json object and returns it
  return aylienDataFromJson(utf8.decode(response.bodyBytes));
}
