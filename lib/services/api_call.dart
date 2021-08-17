import '../constants/api_path.dart';
import '../models/aylien_data.dart';
import 'package:http/http.dart' as http;

const queryParameters = {
  "source.locations.country[]": "US",
  "language": "en",
  "body": "COVID",
};

var uri = Uri.https(AYLIEN_AUTH, AYLIEN_PATH, queryParameters);

Future<AylienData> getAylienData() async {
  var response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Application-ID': AYLIEN_APP_ID,
      'X-Application-Key': AYLIEN_APP_KEY,
    },
  );
  return aylienDataFromJson(response.body);
}
