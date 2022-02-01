import 'package:cloned/loginscreen.dart';
import 'package:cloned/registration_screen.dart';
import 'package:cloned/registrationscreen2.dart';
import 'package:cloned/sprinkle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.ref().child("user");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rider App',
      home: RegistrationScreen2(),
      // home: const Sprinkle(),
    );
  }
}


