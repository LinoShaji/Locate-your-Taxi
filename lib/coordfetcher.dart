import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;

class CoordFetcher extends StatefulWidget {
  const CoordFetcher({Key? key}) : super(key: key);

  @override
  State<CoordFetcher> createState() => _CoordFetcherState();
}

class _CoordFetcherState extends State<CoordFetcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () async {
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            print(position.longitude);
            print(position.latitude);

            String long = position.longitude.toString();
            String lat = position.latitude.toString();
//this code has been fetched from the site https://www.fluttercampus.com/guide/212/get-gps-location/
          },
          child: const Text('Fetch coordinates')),
    );
  }
}
