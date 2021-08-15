import '../constants/api_path.dart';
import '../models/aylien_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var response;
var aylienData;

const queryParameters = {
  "source.locations.country[]": "PH",
  "body": "COVID",
};

var uri = Uri.https(AYLIEN_AUTH, AYLIEN_PATH, queryParameters);

Future<void> getData() async {
  response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Application-ID': AYLIEN_APP_ID,
      'X-Application-Key': AYLIEN_APP_KEY,
    },
  );
  aylienData = aylienDataFromJson(response.body);
}

void printData() async {
  print("aight, we're printin");
  for (var i = 0; i < aylienData.stories.length; i++) {
    print(aylienData.stories[i].body);
  }
}
