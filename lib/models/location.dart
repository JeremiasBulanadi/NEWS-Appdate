// This is a class for storing location details for every entity that's considered a location
import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';

class Loc {
  Loc({
    required this.text,
    this.latlng,
    this.placemark,
    this.addressFromPlacemark: "",
    //getDetails(this.text);
  });

  String text;
  Location? latlng;
  Placemark? placemark;
  String? addressFromPlacemark;

  void getDetails() async {
    print("Getting details for location: $this.text");
    // pesky no value strings aint gettin in my neighborhood
    if (this.text != '') {
      // We're not guaranteed that the entity is actually a place so this might give out null
      this.latlng = await getLatLng(this.text);
      // Just like latlng, null is a possibility
      this.placemark =
          await getPlacemark(this.latlng?.latitude, this.latlng?.longitude);
      // a ready to use address String for readability purposes
      if (this.placemark != null) {
        try {
          this.addressFromPlacemark =
              "${this.placemark?.subThoroughfare} ${this.placemark?.thoroughfare} ${this.placemark?.subLocality} ${this.placemark?.locality} ${this.placemark?.subAdministrativeArea} ${this.placemark?.administrativeArea} ${this.placemark?.country}";
        } catch (err) {
          this.addressFromPlacemark = "N/A";
          print(err);
        }
      } else {
        this.addressFromPlacemark = "N/A";
      }
    }
  }

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        text: json["text"],
        latlng: Location.fromMap(json["latlng"]),
        placemark: Placemark.fromMap(json["placemark"]),
        addressFromPlacemark: json["addressFromPlacemark"],
      );
}
