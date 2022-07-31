import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sign_in/second_screen/list_screen.dart';
import 'package:sign_in/data_lists/stoplist.dart';

const LatLng _testLocation = LatLng(9.454563, 76.743767);

class MapScreenPage extends StatefulWidget {
  static const String idScreen = "mainScreen";
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreenPage> {
  late BitmapDescriptor sourceIcon;
  Set<Marker> _markers = Set<Marker>();
  late Position currentPosition;

  var geoLocator = Geolocator(); // GETS CURRENT USER LOCATION
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/imgs/marker_icon.png');
  }

  void showPins(var pos) {
    LatLng location = LatLng(pos["lat"], pos["long"]);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(pos["name"]),
          position: location,
          icon: sourceIcon,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        place: pos["name"],
                      )),
            );
          }));
    });
  }

  @override
  void initState() {
    super.initState();
    this.setSourceAndDestinationIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your location"),
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: _markers,
            //onTap: changeScreens,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locatePosition();
              getStops();
              //showPins();
            },
          )
        ],
      ),
    );
  }

  void getStops() {
    List<dynamic> responseList = stopList;
    for (var pos in responseList) {
      showPins(pos);
    }
  } //THIS GETS THE LIST OF STOPS FROM DATA_LISTS

}
