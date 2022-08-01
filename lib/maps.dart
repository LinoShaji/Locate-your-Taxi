import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  TextEditingController SourceTextEditingController = TextEditingController();
  double Slong = 0;
  double Slat = 0;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff576F72),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // container 1
                      height: 300,
                      width: 200,
                      margin:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffDFE8CC),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // container 2
                      child: TextFormField(
                        controller: SourceTextEditingController,
                        decoration: const InputDecoration(hintText: 'Source',hintStyle: TextStyle()),
                      ),
                      height: 300,
                      width: 200,
                      padding: EdgeInsets.only(left: 03,right: 03),
                      margin: const EdgeInsets.only(
                          left: 05, right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffDFE8CC),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: GoogleMapsWidget(
                mapType: MapType.hybrid,
                //mapToolbarEnabled: false,
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                //liteModeEnabled: true,
                apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
                sourceLatLng: LatLng(Slong, Slat),
                destinationLatLng: LatLng(Slong, Slat),
              ),
            ),
//             Container(
//               padding: const EdgeInsets.only(bottom: 20, left: 10),
//               alignment: Alignment.bottomLeft,
//               child: TextButton(
//                 onPressed: () async {
//                   Location location = new Location();
//
//                   bool _serviceEnabled;
//                   PermissionStatus _permissionGranted;
//                   LocationData _locationData;
//
//                   _serviceEnabled = await location.serviceEnabled();
//                   if (!_serviceEnabled) {
//                     _serviceEnabled = await location.requestService();
//                     if (!_serviceEnabled) {
//                       return;
//                     }
//                   }
//
//                   _permissionGranted = await location.hasPermission();
//                   if (_permissionGranted == PermissionStatus.denied) {
//                     _permissionGranted = await location.requestPermission();
//                     if (_permissionGranted != PermissionStatus.granted) {
//                       return;
//                     }
//                   }
//
//                   _locationData = await location.getLocation();
//                   location.onLocationChanged
//                       .listen((LocationData currentLocation) {
//                     // Use current location
//                   });
//                   Geolocator.getCurrentPosition();
//                   List<geo.Placemark> placemarks =
//                       await geo.placemarkFromCoordinates(76.8169063, 9.5451539);
//                   Position position = await Geolocator.getCurrentPosition(
//                       //desiredAccuracy: LocationAccuracy.high
//                       );
//                   print(position.longitude);
//                   print(position.latitude);
//
//                   Slong = position.longitude.toDouble();
//                   Slat = position.latitude.toDouble();
// //this code has been fetched from the site https://www.fluttercampus.com/guide/212/get-gps-location/
//                 },
//                 child: const Image(
//                     image: AssetImage('lib/asset/images/location_on.png')),
//               ),
//             ),
          ],
        ),
      ),
    );
  }
}
