import 'package:cloned/registration_screen.dart';
import 'package:cloned/widgets/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as Loc;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:location/location.dart' as Location;
import 'package:location/location.dart';

class MapsTest extends StatefulWidget {
  MapsTest({Key? key}) : super(key: key);
  static const String idScreen = "Login";

  @override
  State<MapsTest> createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController DestinationTextEditingController = TextEditingController();

  late final GoogleMapController _controller;

  void _currentLocation() async {
    final GoogleMapController controller = await _controller;
    LocationData? currentLocation;
    var location = new Location.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
        zoom: 15)));
  }

  getLocation() async {
    List<Loc.Location> locations = await locationFromAddress(DestinationTextEditingController.text);

  }

  // Marker origin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GoogleMapsWidget(
              onMapCreated: (controller) {
                _controller = controller;
              },
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
              sourceLatLng: const LatLng(76.8169063, 9.5451539),
              destinationLatLng: const LatLng(76.8169063, 9.5451539)),
          Center(
            child: Column(
              children: [
                AppFormField2(
                    hintText: 'YOUR LOCATION',
                    Icon: const Icon(Icons.gps_fixed),
                    controller: locationTextEditingController),
                const SizedBox(height: 10),
                AppFormField2(
                    hintText: 'CHOOSE DESTINATION',
                    Icon: const Icon(Icons.flag),
                    controller: DestinationTextEditingController),
                // Container(height: 50,width: 150,child: TextButton(onPressed: (){}, child: Text('Locate your Taxi',style: TextStyle(color: Colors.black,fontFamily: 'lato'),)))
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffA5C9CA))),
                    onPressed: () async {
                      if (!locationTextEditingController.text.isEmpty) {
                        displayToastMessage('enter your current location', context);
                      } else if (!DestinationTextEditingController.text.isEmpty) {
                        displayToastMessage('enter your destination', context);
                      } else {
                        await getLocation();
                      }
                    },
                    child: const Text(
                      'Locate Your Taxi',
                      style: TextStyle(color: Colors.black, fontFamily: 'lato'),
                    )),

              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 05, bottom: 05),
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: _currentLocation,
                child: const Icon(Icons.gps_fixed),
              )),
        ]),
      ),
    );
  }
}
