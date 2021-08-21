import 'package:geocoding/geocoding.dart';

// Gets user location details
// we mostly just want:
// ISO Country Code, Country, Subadministrative area, and the Locality
// TODO:
// - Actually implement getting user location instead of just testing geocoding
void getLocation() async {
  // NOTE: This is all for testing, will all be replaced
  List<Location> latlngs =
      await locationFromAddress("Philippines, Pampanga, Holy Angel University");
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latlngs[0].latitude, latlngs[0].longitude);

  print(latlngs[0]);
  print("\n");
  print(placemarks[0]);
  print("\n");
  print(placemarks[1]);
}
