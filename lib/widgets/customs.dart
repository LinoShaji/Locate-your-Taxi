import'package:flutter/cupertino.dart';
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
    return Container(
      decoration: BoxDecoration(color: Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
      width: 300,
      height: 70,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        style: TextStyle(fontFamily: 'lato'),
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(fontFamily: 'Dongle',fontWeight: FontWeight.w400,fontSize: 22),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.Icon,
          hintText: widget.hintText,

        ),
      ),
    );
  }
}

class CstmTxtBtn extends StatefulWidget {
  const CstmTxtBtn({Key? key}) : super(key: key);

  @override
  State<CstmTxtBtn> createState() => _CstmTxtBtnState();
}

class _CstmTxtBtnState extends State<CstmTxtBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 03),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffE7F6F2))),
          onPressed: () {},
          child: const Text(
            'Locate Your Taxi',
            style: TextStyle(color: Colors.black, fontFamily: 'lato'),
          )),
    );
  }
}

