import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:geolocator/geolocator.dart';

class MainScreen extends StatelessWidget {
  static const String idScreen = "login";

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMapsWidget(
          mapToolbarEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          //liteModeEnabled: true,
          apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
          sourceLatLng: LatLng(40.484000837597925, -3.369978368282318),
          destinationLatLng: LatLng(40.48017307700204, -3.3618026599287987),
        ),
    );
  }
}
