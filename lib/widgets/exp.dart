// import 'dart:html';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Exp extends StatelessWidget {
//   String _selectedLocation = 'please choose a location';
//    Exp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:  DropdownButton(
//     value: _selectedLocation,
//     onChanged: (String newValue) {
//       setState(() {
//         _selectedLocation = newValue;
//       });
//     },
//     items: _locations.map((String location) {
//     return new DropdownMenuItem<String>(
//     child: new Text(location),
//     );
//     }).toList(),,);
//         List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
//
//   }
// }
