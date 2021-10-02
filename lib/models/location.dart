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
        latlng: latlngFromJson(json["latlng"]),
        placemark: placemarkFromJson(json["placemark"]),
        addressFromPlacemark: json["addressFromPlacemark"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "latlng": latlngtoJson(latlng),
        "placemark": placemarkToJson(placemark),
        "addressFromPlacemark": addressFromPlacemark
      };

  static Location? latlngFromJson(Map<String, dynamic> json) {
    if (json["latitude"] == null || json["longitude"] == null) {
      return null;
    } else {
      return Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
        timestamp: new DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      );
    }
  }

  Map<String, dynamic> latlngtoJson(Location? latlng) => {
        "latitude": latlng?.latitude == null ? null : latlng?.latitude,
        "longitude": latlng?.longitude == null ? null : latlng?.longitude,
        "timestamp": latlng?.timestamp.millisecondsSinceEpoch
      };

  static Placemark placemarkFromJson(Map<String, dynamic> json) => Placemark(
      name: json["name"],
      street: json["street"],
      isoCountryCode: json["isoCountryCode"],
      country: json["country"],
      postalCode: json["postalCode"],
      administrativeArea: json["administrativeArea"],
      subAdministrativeArea: json["subAdministrativeArea"],
      locality: json["locality"],
      subLocality: json["subLocality"],
      thoroughfare: json["thoroughfare"],
      subThoroughfare: json["subThoroughfare"]);

  Map<String, dynamic> placemarkToJson(Placemark? placemark) => {
        "name": placemark?.name,
        "street": placemark?.street,
        "isoCountryCode": placemark?.isoCountryCode,
        "country": placemark?.country,
        "postalCode": placemark?.postalCode,
        "administrativeArea": placemark?.administrativeArea,
        "subAdministrativeArea": placemark?.subAdministrativeArea,
        "locality": placemark?.locality,
        "subLocality": placemark?.subLocality,
        "thoroughfare": placemark?.thoroughfare,
        "subThoroughfare": placemark?.subThoroughfare
      };
}
