// @dart=2.9
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/confirm_email.dart';
import '../auth/register.dart';
import '../auth/reset_password.dart';
import '../screens/home_page.dart';
import '../shared/colors.dart';
import '../shared/dialog.dart';
import '../shared/side_menu.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer _timer;
  void _login() async {
    try {
      EasyLoading.show(status: 'loading...');
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      if (result.user.uid != null) {
        EasyLoading.showSuccess('Done Login!');
        EasyLoading.dismiss();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      if (e.toString().contains('There is no user')) {
        openDialog('login', 'user not found', context);
        EasyLoading.dismiss();
      } else if (e.toString().contains('The password is invalid')) {
        openDialog('login', 'incorrect password', context);
        EasyLoading.dismiss();
      } else {
        openDialog('login', 'error login you in', context);
        EasyLoading.dismiss();
      }
    }
  }

  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });

    // EasyLoading.removeCallbacks();
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MColors.backcolor,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Image.asset('assets/img/main_top.png'),
                    width: size.width * 0.3,
                    top: 0,
                    left: 0,
                  ),
                  Positioned(
                    child: Image.asset('assets/img/login_bottom.png'),
                    width: size.width * 0.3,
                    bottom: 0,
                    right: 0,
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.all(25),
                        child: Lottie.asset('assets/img/astro.json')),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 150),
                          child: Text(
                            "Login",
                            style: GoogleFonts.mulish(
                                color: MColors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 270, left: 15, right: 15, bottom: 10),
                            width: 250,
                            height: 50,
                            child: TextFormField(
                                controller: _email,
                                cursorColor: Colors.black,
                                validator: (val) => val.isEmpty ||
                                        !val.contains("@") ||
                                        val.split('@')[1] != null
                                    ? "enter a valid email"
                                    : null,
                                style: GoogleFonts.cairo(
                                    textStyle: TextStyle(color: Colors.black)),
                                autofocus: false,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12.0, top: 0.0),
                                    hintText: "Email",
                                    hintStyle: GoogleFonts.cairo(
                                        textStyle:
                                            TextStyle(color: Colors.black)),
                                    filled: true,
                                    fillColor: Colors.white54,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0))))),
                        Container(
                            margin: EdgeInsets.only(
                                top: 5, left: 15, right: 15, bottom: 10),
                            width: 250,
                            height: 50,
                            child: TextField(
                                controller: _password,
                                obscureText: true,
                                cursorColor: Colors.black,
                                style: GoogleFonts.cairo(
                                    textStyle: TextStyle(color: Colors.black)),
                                autofocus: false,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12.0, top: 0.0),
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.cairo(
                                        textStyle:
                                            TextStyle(color: Colors.black)),
                                    filled: true,
                                    fillColor: Colors.white54,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(width: 0))))),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5, left: 15, right: 15, bottom: 10),
                          width: 250,
                          child: RaisedButton(
                            onPressed: () => _login(),
                            splashColor: Colors.indigoAccent,
                            color: MColors.color3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Login",
                                style: GoogleFonts.mulish(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 0, left: 15, right: 15, bottom: 10),
                          width: 250,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            splashColor: MColors.color3,
                            color: Colors.indigoAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("sign up",
                                style: GoogleFonts.mulish(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPassword()));
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: GoogleFonts.cairo(color: Colors.white),
                              )),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}
