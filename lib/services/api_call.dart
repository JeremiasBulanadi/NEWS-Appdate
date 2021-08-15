import '../constants/api_path.dart';
import '../models/aylien_data.dart';
import 'package:http/http.dart' as http;

var response;
var aylienData;

const queryParameters = {
  "source.locations.country[]": "PH",
  "language": "en",
  "body": "COVID",
};

var uri = Uri.https(AYLIEN_AUTH, AYLIEN_PATH, queryParameters);

Future<AylienData> getAylienData() async {
  response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Application-ID': AYLIEN_APP_ID,
      'X-Application-Key': AYLIEN_APP_KEY,
    },
  );
  return aylienDataFromJson(response.body);
}

void printData() {
  print("aight, we're printin");
  for (var i = 0; i < aylienData.stories.length; i++) {
    print(aylienData.stories[i].title);
  }
}
