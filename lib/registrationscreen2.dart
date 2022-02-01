import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloned/loginscreen.dart';
import 'package:cloned/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

class RegistrationScreen2 extends StatefulWidget {
  const RegistrationScreen2({Key? key}) : super(key: key);

  @override
  _RegistrationScreen2State createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  bool _isObscure = false;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final FirebaseAuth _FirebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    final User? FirebaseUser =
        (await _FirebaseAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text).catchError((errMsg) {
          displayToastMessage("Error  " + errMsg.toString(), context);
        }))
            .user;

    if(User != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };

      userRef.child(FirebaseUser!.uid).set(userDataMap);
      displayToastMessage("Congratulations your user account has been created ", context);


    }
  }

  @override
  Widget build(BuildContext context) {
    void toggleVisibility() {
      setState(() {
        _isObscure = !_isObscure;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: SizedBox(
                height: 250,
                width: 250,
                child: Image(
                    image: AssetImage("lib/asset/images/pngwing.com.png")),
              ),
            ),
            AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
              TyperAnimatedText("Register As A New Rider",
                  textStyle:
                  const TextStyle(color: Colors.black, fontSize: 30)),
            ]),
            const SizedBox(
              height: 20,
            ),
            AppFormField(
                hintText: 'name',
                inputType: TextInputType.name,
                controller: nameTextEditingController),
            const SizedBox(
              height: 20,
            ),
            AppFormField(
                hintText: 'email',
                inputType: TextInputType.emailAddress,
                controller: emailTextEditingController),
            const SizedBox(
              height: 20,
            ),
            AppFormField(
                hintText: 'phone',
                inputType: TextInputType.phone,
                controller: phoneTextEditingController),
            const SizedBox(
              height: 20,
            ),
            AppFormField(
              hintText: 'password',
              inputType: TextInputType.visiblePassword,
              controller: passwordTextEditingController,
              isObscure: !_isObscure,
              icon: InkWell(
                onTap: toggleVisibility,
                child: Icon(
                  _isObscure == false ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameTextEditingController.text.length < 3) {
                  Fluttertoast.showToast(
                      msg: "Name must contain atleast 3 characters ");
                } else if (!emailTextEditingController.text.contains("@")) {
                  displayToastMessage("Email address is not valid", context);
                } else if (phoneTextEditingController.text.length < 6) {
                  displayToastMessage("Phone number is mandatory", context);
                } else if (passwordTextEditingController.text.length < 6) {
                  displayToastMessage(
                      "password must contain atleast 7 charecters", context);
                }
              },
              child: const Text(
                'Create Account',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  'Already have an account? Login here',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ))
          ], //children
        ),
      ),
    );
  }
}

class AppFormField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final bool? isObscure;
  final TextEditingController controller;
  final Widget? icon;

  const AppFormField({Key? key,
    required this.hintText,
    required this.inputType,
    required this.controller,
    this.isObscure,
    this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure ?? false,
        keyboardType: inputType,
        decoration: InputDecoration(
          suffixIcon: icon ?? const SizedBox(),
          hintText: hintText,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
