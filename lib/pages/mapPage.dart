import 'dart:typed_data';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'package:news_appdate/pages/news.dart';
import 'package:provider/provider.dart';
import '../widgets/news_card.dart';
import '../models/location.dart';
import '../models/aylien_data.dart';
import '../widgets/marker_widget.dart';
import '../providers/news_provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'newsPage.dart';

import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Story? _news_story;
  List<Marker> markers = [];
  LatLng? _initialLocation;
  StreamSubscription? _locationSubscription;
  BitmapDescriptor? pinLocation;
  loc.Location location = new loc.Location();
  loc.Location _locationTracker = loc.Location();
  GoogleMapController? _controller;
  Position? _currentPosition;
  Position? first_coords;
  @override
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(15.132722, 120.589111),
    zoom: 15,
  );

  void updateMarker(loc.LocationData newLocationData) {
    Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    });

    LatLng latLng =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    this.setState(() {
      markers.add(Marker(
          markerId: MarkerId('mylocation'),
          position: latLng,
          draggable: false));
    });
  }

  void mapLocation() async {
    try {
      var location = await _locationTracker.getLocation();

      updateMarker(location);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }
      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarker(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
    }
  }

  setMarkers() async {
    List<Story>? stories = context.watch<NewsProvider>().getLocationalNews();
    //final query = _news_story!.locations!.first.text;
    //var address = await locationFromAddress(query);
    //first_coords = address as Position?;

    if (stories == null) {
      print("There are no stories");
    } else {
      for (Story story in stories) {
        if (story.locations == null) {
          print("There are no locations in this news");
        } else {
          for (int index = 0; index < story.locations!.length; index++) {
            if (story.locations![index].latlng != null) {
              markers.add(new Marker(
                  markerId: MarkerId(story.title),
                  draggable: false,
                  position: new LatLng(story.locations![index].latlng!.latitude,
                      story.locations![index].latlng!.longitude),
                  infoWindow: InfoWindow(
                      title: story.title,
                      snippet: story.locations?[index].placemark?.name,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsPage()));
                      })));
            }
          }
        }
      }
    }
  }

  Widget build(BuildContext context) {
    setMarkers();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: initialLocation,
            markers: Set.of(markers),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Positioned(
            bottom: 10,
            right: 5,
            child: MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Icon(
                  Icons.location_searching,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
                onPressed: () {
                  mapLocation();
                  for (Marker marker in markers) {
                    print(marker.position.toString());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
