import 'package:flutter/material.dart';
import 'dart:math';

class Sprinkle extends StatefulWidget {
  const Sprinkle({Key? key}) : super(key: key);

  @override
  State<Sprinkle> createState() => _SprinkleState();
}

class _SprinkleState extends State<Sprinkle> {
  List colors = [
    Colors.red,
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey
  ];
  Random random = Random();

  int index = 0;
  int lastIndex = 0;

  void changeIndex() {
    setState(() {
      lastIndex = index;
      index = random.nextInt(22);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[lastIndex],
      body: InkWell(
        splashColor: colors[index],
        onTap: () => changeIndex(),
      ),
    );
  }
}
