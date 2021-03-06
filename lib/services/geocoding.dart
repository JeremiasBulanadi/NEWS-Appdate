import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as LOC;

// Gets user location details
// we mostly just want:
// ISO Country Code, Country, Subadministrative area, and the Locality

// This is for testing, will be replaced
Future<LOC.LocationData?> getUserLocation() async {
  var location = new LOC.Location();
  var _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  var _permissionGranted = await location.hasPermission();
  if (_permissionGranted == LOC.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != LOC.PermissionStatus.granted) {
      return null;
    }
  }

  LOC.LocationData currentLocation = await location.getLocation();

  return currentLocation;
}

// Will give out a Location object with latitude and longitude values...
// ...Unless it can't find the specified location, in which case it returns null
Future<Location?> getLatLng(String location) async {
  try {
    List<Location> latlngs = await locationFromAddress(location);
    return latlngs[0];
  } on NoResultFoundException catch (err) {
    print(err);
    return null;
  }
}

// Will give out a Placemark object with the address...
// ...Unless latlng couldn't be found, in which case it returns null
Future<Placemark?> getPlacemark(double? latitude, double? longitude) async {
  if (latitude != null && longitude != null) {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      return placemarks[0];
    } on PlatformException catch (err) {
      print(err);
      return null;
    }
  } else {
    return null;
  }
}
