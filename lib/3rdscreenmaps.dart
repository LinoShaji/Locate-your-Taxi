import 'package:cloned/registration_screen.dart';
import 'package:cloned/widgets/customs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:location/location.dart' as Location;
import 'package:location/location.dart';
import 'package:cloned/loginscreen.dart';

class MapsTest extends StatefulWidget {
  MapsTest({Key? key, }) : super(key: key);
  static const String idScreen = "Login";

  @override
  State<MapsTest> createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  double poslat = 0;
  double poslong = 0;
  double currentloc = 0;
  bool _showScreen = false;
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController DestinationTextEditingController = TextEditingController();
   void initState(){
     super.initState();
     CurrentUseremailid = FirebaseAuth.instance.currentUser!.email.toString();
   }

  late final GoogleMapController _controller;

  Future getUser(
      {required String name,
        }) async {
    final docUser = FirebaseFirestore.instance
        .collection('requestingrides')
        .doc(CurrentUseremailid);
    final json = {
      "current latitude" : poslat,
      "current longitude" : poslong,
      "notification id" : null,
    };
    await docUser.set(json);
  }


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

  void currloc() async {
    Position position = await Geolocator.getCurrentPosition();
    print(position);
    poslat = position.latitude.toDouble();
    poslong = position.longitude.toDouble();
    currentloc = poslat + poslong;
  }


  void _toggleVisibility() {
    setState(() {
      _showScreen;
    });
  }


  // Marker origin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Visibility(
            visible: true,
            child: GoogleMapsWidget(defaultCameraLocation: LatLng(76.8169063, 9.5451539),
                onMapCreated: (controller) {
                  _controller = controller;
                },
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                apiKey: 'AIzaSyBH_hc-qgz7GxZ2P5Ol7S4HykS51cABabU',
                sourceLatLng: const LatLng(76.8169063, 9.5451539),
                destinationLatLng: const LatLng(76.8169063, 9.5451539)),
          ),
          Center(
            child: Column(
              children: [
                AppFormField2(
                    hintText: 'FROM',
                    Icon: const Icon(Icons.gps_fixed),
                    controller: locationTextEditingController),
                const SizedBox(height: 10),
                AppFormField2(
                    hintText: 'TO',
                    Icon: const Icon(Icons.flag),
                    controller: DestinationTextEditingController),
                // Container(height: 50,width: 150,child: TextButton(onPressed: (){}, child: Text('Locate your Taxi',style: TextStyle(color: Colors.black,fontFamily: 'lato'),)))
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffA5C9CA))),
                    onPressed: () async {
                      print(
                          "test 1 passed"); // for testing weather the code will return the locaton coordinates
                      currloc();
                      setState(() {
                        _showScreen = true;
                      });
                      if (!locationTextEditingController.text.isEmpty) {
                        displayToastMessage(
                            'enter your location where ypu are planning to start the ride', context);
                      } else if (!DestinationTextEditingController
                          .text.isEmpty) {
                        displayToastMessage('enter your destination', context);
                      } else {
                        Position position = await Geolocator.getCurrentPosition();
                        getUser(name: "lno1");
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
          Visibility(
            visible: _showScreen,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: const Text('Searching....',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              fontFamily: 'Dongle')),
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 0.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.grey.shade200),
                      width: 200,
                      height: 50,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                          child: const Image(image: AssetImage("lib/asset/images/close button.png")),
                          onPressed: () {
                            setState(() {
                              _showScreen = false;
                            });
                          }))
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
