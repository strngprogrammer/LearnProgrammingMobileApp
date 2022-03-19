// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/colors.dart';
import '../shared/dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  void _reset() async {
    try {
      var res = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text);
      await openDialog("reset password", "email sent", context);
    } catch (e) {
      if (e.toString().contains('There is no user record')) {
        openDialog('reset password', "email not found", context);
      }
    }
  }

  TextEditingController _email = TextEditingController();
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
                child: Stack(alignment: Alignment.center, children: [
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
                          child: RaisedButton(
                            onPressed: () => _reset(),
                            splashColor: Colors.indigoAccent,
                            color: MColors.color3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Reset password",
                                style: GoogleFonts.mulish(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("back to Login"))
                      ]),
                ]))));
  }
}
