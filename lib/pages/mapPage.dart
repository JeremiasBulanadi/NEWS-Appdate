import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  StreamSubscription? _locationSubscription;
  BitmapDescriptor? pinLocation;
  late Marker marker;
  Location location = new Location();
  Location _locationTracker = Location();
  GoogleMapController? _controller;
  late Position _currentPosition;
  @override
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(15.132722, 120.589111),
    zoom: 15,
  );

  void updateMarker(LocationData newLocationData) {
    Geolocator.getCurrentPosition().then((Position position){
      setState(() {
        _currentPosition = position;
      });
    });
    var lastpos = Geolocator.getLastKnownPosition();
    var lat = _currentPosition.latitude;

    LatLng latLng = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId('mylocation'), position: latLng, draggable: false);
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
                  target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarker(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: initialLocation,
              markers: Set.of((marker != null) ? [marker] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              }),
          Positioned(
            top: 5,
            right: 5,
            left: 5,
            child: Container(
              width: 200,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
                boxShadow: kElevationToShadow[6],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search a location',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ))
                ],
              ),
            ),
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
                }),
          ),
        ],
      ),
    );
  }
}
