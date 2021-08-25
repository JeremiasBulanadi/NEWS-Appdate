// This is a class for storing location details for every entity that's considered a location

import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';

class Loc {
  Loc(String loc) {
    getDetails(loc);
  }

  void getDetails(loc) async {
    this.text = loc;
    // We're not guaranteed that the entity is actually a place so this might give out null
    this.latlng = await getLatLng(loc);
    // Just like latlng, null is a possibility
    this.placemark = await getPlacemark(this.latlng);
  }

  late String text;
  late Location? latlng;
  late Placemark? placemark;
}
