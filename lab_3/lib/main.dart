import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3: Google Map',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
          backgroundColor: Colors.green[700],
        ),
        body: Center(
          child: Maps(),
        ),
      ),
    );
  }
}

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double screenHeight = 0.00, screenWidth = 0.00;
  String maplocation = "";
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(6.4676929, 100.5067673);
  MarkerId markerId1 = MarkerId("marker");
  Set<Marker> _markers = Set();
  String _address = "Locating...";
  double latitude, longitude, restlat, restlon;
  GoogleMapController gmcontroller;
  CameraPosition _home;
  var first;

  @override
  void initState() {
    super.initState();
    _getLocation(_center);
    _markers.add(Marker(
      markerId: markerId1,
      position: _center,
      draggable: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, newSetState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 2 * (MediaQuery.of(context).size.height / 3),
                width: MediaQuery.of(context).size.width - 10,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 17.0,
                  ),
                  markers: _markers.toSet(),
                  onTap: (newLatLng) {
                    _loadLoc(newLatLng, newSetState);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  height: MediaQuery.of(context).size.height / 5.2,
                  width: MediaQuery.of(context).size.width - 10,
                  child: Column(
                    children: [
                      Text("Latitude: " + latitude.toString() + "\n" +"Longitude: " + longitude.toString()),
                      Text("" + _address.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _getLocation(position) async {
    if (position != null) {
      final coordinates =
          new Coordinates(position.latitude, position.longitude);

      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      first = addresses.first.addressLine;

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        _address = first;
        print("Test " + _address.toString());
        return;
      });
    }
  }

  void _loadLoc(LatLng loc, newSetState) async {
    newSetState(() {
      print("insetstate");
      _markers.clear();
      latitude = loc.latitude;
      longitude = loc.longitude;
      _getLocationfromlatlng(latitude, longitude, newSetState);
      _home = CameraPosition(
        target: loc,
        zoom: 17,
      );
      _markers.add(Marker(
        markerId: markerId1,
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: 'New Location',
          snippet: 'New Mark Location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
    CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17,
    );
    _newhomeLocation();
  }

  _getLocationfromlatlng(double latitude, double longitude, newSetState) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    newSetState(() {
      _address = first.addressLine;
      if (_address != null) {
        latitude = latitude;
        longitude = longitude;
        return;
      }
    });
    setState(() {
      _address = first.addressLine;
      if (_address != null) {
        latitude = latitude;
        longitude = longitude;
        return;
      }
    });
  }

  Future<void> _newhomeLocation() async {
    gmcontroller = await _controller.future;
    gmcontroller.animateCamera(CameraUpdate.newCameraPosition(_home));
  }
}
