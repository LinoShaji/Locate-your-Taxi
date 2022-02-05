import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloned/loginscreen.dart';
import 'package:cloned/main.dart';
import 'package:cloned/main_screen.dart';
import 'package:cloned/widgets/progressdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isObscure = false;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController2 = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, please wait...",);
        }
    );
    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg) {
          Navigator.pop(context);
      displayToastMessage("Error:  " + errMsg.toString(), context);
    }))
        .user;

    if (User != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      userRef.child(firebaseUser!.uid).set(userDataMap);
      displayToastMessage(
          "Congratulation, your user account has been created. ", context);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MainScreen()), (route) => false);
    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("New user account has not been created", context);
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
        child: Container(
          padding: EdgeInsets.all(09),
          child: Column(
            children: [
              Container(
                child: const Image(
                  image: AssetImage('lib/asset/images/pngwing.com.png'),
                  width: 350.0,
                  height: 350.0,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Regsiter As A Rider',
                      textStyle:
                      const TextStyle(color: Colors.black, fontSize: 20)),
                ],
                totalRepeatCount: 1,
              ),
              const SizedBox(height: 8.0),
              AppFormField(
                  controller: nameTextEditingController,
                  inputType: TextInputType.name,
                  hintText: 'Enter Your Name'),
              const SizedBox(
                height: 5.0,
              ),
              AppFormField(
                  controller: emailTextEditingController,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Email ID'),
              const SizedBox(
                height: 5.0,
              ),
              AppFormField(
                  controller: phoneTextEditingController,
                  inputType: TextInputType.phone,
                  hintText: 'Enter the phone number'),
              const SizedBox(
                height: 8.0,
              ),
              AppFormField(
                controller: passwordTextEditingController,
                inputType: TextInputType.visiblePassword,
                isObscure: !_isObscure,
                hintText: 'Create password',
                icon: InkWell(
                  onTap: toggleVisibility,
                  child: Icon(_isObscure == false
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
              AppFormField(
                inputType: TextInputType.visiblePassword,
                hintText: 'Re-enter your password',
                controller: passwordTextEditingController2,
                isObscure: !_isObscure,
                icon: InkWell(
                  onTap: toggleVisibility,
                  child: Icon(_isObscure == false
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () {
                    if (nameTextEditingController.text.length < 3) {
                      Fluttertoast.showToast(
                          msg: "Name must be atleast 3 charecters. ");
                    } else if (!emailTextEditingController.text.contains("@")) {
                      displayToastMessage(
                          "Email address is not valid", context);
                    } else if (phoneTextEditingController.text.isEmpty) {
                      displayToastMessage("Phone number is mandatory", context);
                    } else if (passwordTextEditingController.text.length < 6) {
                      (displayToastMessage(
                          "Password must be atleast 7 charecters", context));
                    }else if(passwordTextEditingController.text != passwordTextEditingController2.text){
                      displayToastMessage('passwords does not match', context);
                    }
                    else {
                      registerNewUser(context);
                    }
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  color: Colors.yellow,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Already have an Account? Login Here',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

class AppFormField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? isObscure;
  final Widget? icon;

  const AppFormField({Key? key,
    required this.inputType,
    required this.hintText,
    required this.controller,
    this.isObscure,
    this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isObscure ?? false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: icon ?? const SizedBox(),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          fillColor: const Color(0xffdae3f2),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
