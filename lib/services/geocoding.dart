import 'package:geocoding/geocoding.dart';

// Gets user location details
// we mostly just want:
// ISO Country Code, Country, Subadministrative area, and the Locality
// TODO:
// - Actually implement getting user location instead of just testing geocoding

// This is for testing, will be replaced
void getLocation(String location) async {
  List<Location> latlngs = await locationFromAddress(location);
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latlngs[0].latitude, latlngs[0].longitude);

  print(latlngs[0]);
  print("\n");
  print(placemarks[0]);
  print("\n");
  print(placemarks[1]);
}

// Will give out a Location object with latitude and longitude values...
// ...Unless it can't find the specified location, in which case it returns null
Future<Location?> getLatLng(String location) async {
  try {
    List<Location> latlngs = await locationFromAddress(location);
    return latlngs[0];
  } on NoResultFoundException catch (e) {
    return null;
  }
}

// Will give out a Placemark object with the address...
// ...Unless latlng couldn't be found, in which case it returns null
Future<Placemark?> getPlacemark(Location? location) async {
  if (location != null) {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    return placemarks[0];
  } else {
    return null;
  }
}
