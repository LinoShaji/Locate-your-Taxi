import 'package:cloned/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

class MainScreen extends StatelessWidget {
  static const String idScreen = "login";

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Container(
          height: 300,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(30)),
        ),
        Stack(children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Maps()));
              },
              child: Container(height: 200)),
          Container(
            child: const GoogleMapsWidget(
              mapType: MapType.hybrid,
              //mapToolbarEnabled: false,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              //liteModeEnabled: true,
              apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
              sourceLatLng: LatLng(76.861061, 9.522040),
              destinationLatLng: LatLng(76.820450, 9.531650),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(30)),
          )
        ])
      ]),
    ));
  }
}
