import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/aylien_data.dart';
import '../providers/news_provider.dart';
import 'newsPage.dart';

import 'dart:async';

// This is just for differentiating the markers put on the map
enum NewsListType { locational, recommended, searched }

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  loc.LocationData? userLocation;
  bool hasSetInitialLocation = false;
  List<Marker> markers = [];
  //StreamSubscription? _locationSubscription;
  BitmapDescriptor? pinLocation;
  loc.Location location = new loc.Location();
  //loc.Location _locationTracker = loc.Location();
  GoogleMapController? _controller;
  Position? _currentPosition;

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
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          markerId: MarkerId('MY LOCATION'),
          position: latLng,
          draggable: false));
    });
  }

  void focusOnUser() {
    if (_controller != null) {
      _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(userLocation?.latitude ?? 0, userLocation?.longitude ?? 0),
          zoom: 10)));
    }
  }

  setMarkers() async {
    markers = [];

    NewsData? newsData = context.watch<NewsProvider>().newsData;
    if (newsData.locationalNews != null &&
        newsData.locationalNews!.length > 0) {
      addMarkers(newsData.locationalNews, NewsListType.locational);
    } else {
      print("mapPage.dart: Unfortunate, but there is no locational news");
    }

    if (newsData.recommendedNews != null &&
        newsData.recommendedNews!.length > 0) {
      addMarkers(newsData.recommendedNews, NewsListType.recommended);
    } else {
      print("mapPage.dart: Unfortunate, but there is no recommended news");
    }

    if (newsData.searchedNews != null && newsData.searchedNews!.length > 0) {
      addMarkers(newsData.searchedNews, NewsListType.searched);
    } else {
      print("mapPage.dart: Unfortunate, but there is no searched news");
    }
    //final query = _news_story!.locations!.first.text;
    //var address = await locationFromAddress(query);
    //firstCoords = address as Position?;
  }

  addMarkers(List<Story>? stories, NewsListType newsListType) {
    BitmapDescriptor markerIcon;
    if (newsListType == NewsListType.locational) {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    } else if (newsListType == NewsListType.recommended) {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    }

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
                  icon: markerIcon,
                  draggable: false,
                  position: new LatLng(story.locations![index].latlng!.latitude,
                      story.locations![index].latlng!.longitude),
                  infoWindow: InfoWindow(
                      title: story.title,
                      snippet: story.locations?[index].addressFromPlacemark,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsPage(story: story)));
                      })));
            }
          }
        }
      }
    }
  }

  Widget build(BuildContext context) {
    // This part isnt fast enough to get user's location
    userLocation = Provider.of<loc.LocationData?>(context);
    markers.add(new Marker(
      markerId: MarkerId("userLocation"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(
          title: "Your Location",
          snippet:
              "${userLocation?.latitude ?? "?"}, ${userLocation?.longitude ?? "?"}"),
    ));

    setMarkers();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    userLocation?.latitude ?? 0, userLocation?.longitude ?? 0),
                zoom: 0),
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
                  Icons.my_location,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
                onPressed: () {
                  focusOnUser();
                  // for (Marker marker in markers) {
                  //   print(marker.position.toString());
                  // }
                }),
          ),
        ],
      ),
    );
  }
}
