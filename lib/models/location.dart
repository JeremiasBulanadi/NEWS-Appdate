// This is a class for storing location details for every entity that's considered a location
import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';

class Loc {
  Loc(String loc) {
    getDetails(loc);
  }

  void getDetails(String loc) async {
    this.text = loc;
    // pesky no value strings aint gettin in my neighborhood
    if (loc != '') {
      // We're not guaranteed that the entity is actually a place so this might give out null
      this.latlng = await getLatLng(loc);
      // Just like latlng, null is a possibility
      this.placemark =
          await getPlacemark(this.latlng?.latitude, this.latlng?.longitude);
      // a ready to use address String for readability purposes
      if (this.placemark != null) {
        this.addressFromPlacemark =
            "${this.placemark?.subThoroughfare} ${this.placemark?.thoroughfare} ${this.placemark?.subLocality} ${this.placemark?.locality} ${this.placemark?.subAdministrativeArea} ${this.placemark?.administrativeArea} ${this.placemark?.country}";
      } else {
        this.addressFromPlacemark = null;
      }
    }
  }

  late String text;
  late Location? latlng;
  late Placemark? placemark;
  late String? addressFromPlacemark;
}
