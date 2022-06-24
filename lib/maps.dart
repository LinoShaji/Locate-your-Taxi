import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart'as geo;


class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const GoogleMapsWidget(
              mapToolbarEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              //liteModeEnabled: true,
              apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
              sourceLatLng: LatLng(40.484000837597925, -3.369978368282318),
              destinationLatLng: LatLng(40.48017307700204, -3.3618026599287987),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 20, left: 10),
                alignment: Alignment.bottomLeft,
                child: TextButton(
                    onPressed: () async {Location location = new Location();

                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }

                    _locationData = await location.getLocation();
                    location.onLocationChanged.listen((LocationData currentLocation) {
                      // Use current location
                    });
                    Geolocator.getCurrentPosition();
                    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(52.2165157, 6.9437819);
                    },
                    child: const Image(
                        image: AssetImage('lib/asset/images/location_on.png'))))
          ],
        ),
      ),
    );
  }
}
