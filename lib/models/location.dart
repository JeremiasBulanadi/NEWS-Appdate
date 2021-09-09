// This is a class for storing location details for every entity that's considered a location
import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';

class Loc {
  Loc(String loc) {
    // latlng = null;
    // placemark = null;
    // addressFromPlacemark = null;
    getDetails(loc);
  }

  void getDetails(String loc) async {
    print("Getting details for location: ${loc}");
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
        try {
          this.addressFromPlacemark =
              "${this.placemark?.subThoroughfare} ${this.placemark?.thoroughfare} ${this.placemark?.subLocality} ${this.placemark?.locality} ${this.placemark?.subAdministrativeArea} ${this.placemark?.administrativeArea} ${this.placemark?.country}";
        } catch (err) {
          this.addressFromPlacemark = null;
          print(err);
        }
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
