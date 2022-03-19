// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import './confirm_email.dart';
import '../shared/colors.dart';
import '../shared/dialog.dart';
import 'package:lottie/lottie.dart';
import '../globals.dart' as glo;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  void _reg() async {
    var _user = FirebaseAuth.instance;

    try {
      EasyLoading.show(status: "Signing you up ...");
      var res = await _user.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      EasyLoading.dismiss();
      if (res.user.emailVerified == false) {
        glo.name = _name.text;

        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => VerifyEmail()));
      }
    } catch (e) {
      if (e.toString().contains('The email address is already')) {
        openDialog("signup", 'email already in use', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: MColors.backcolor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.mulish(
                            color: MColors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 240, left: 15, right: 15, bottom: 10),
                        width: 250,
                        height: 50,
                        child: TextFormField(
                            controller: _name,
                            cursorColor: Colors.black,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(color: Colors.black)),
                            autofocus: false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 12.0, top: 0.0),
                                hintText: "Name",
                                hintStyle: GoogleFonts.cairo(
                                    textStyle: TextStyle(color: Colors.black)),
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
                                    textStyle: TextStyle(color: Colors.black)),
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
                                    textStyle: TextStyle(color: Colors.black)),
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
                          top: 10, left: 15, right: 15, bottom: 10),
                      width: 250,
                      child: RaisedButton(
                        onPressed: () {
                          _reg();
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
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
