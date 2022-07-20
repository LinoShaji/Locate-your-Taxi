import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFormField2 extends StatefulWidget {
  final String hintText;
  final Widget Icon;
  final TextEditingController controller;

  const AppFormField2(
      {Key? key,
      required this.hintText,
      required this.Icon,
      required this.controller})
      : super(key: key);

  @override
  State<AppFormField2> createState() => _AppFormFieldState2();
}

class _AppFormFieldState2 extends State<AppFormField2> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 300,height: 70,
      padding: EdgeInsets.only(top: 20,left: 10, right: 10),
      child: TextFormField(style: TextStyle(fontFamily: 'lato'),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: 'lato'),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.Icon,
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
