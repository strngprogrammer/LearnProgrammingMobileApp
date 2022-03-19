// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login.dart';
import '../shared/colors.dart';
import '../globals.dart' as glo;

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;

    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      CheckEmailVerfied();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              Container(
                width: 300,
                height: 500,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  elevation: 5,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: IconButton(
                          onPressed: () {
                            user.delete();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "we've sent email to you\nplease verify email to continue!",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Mulish',
                            fontSize: 18),
                      )),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  Future<void> CheckEmailVerfied() async {
    EasyLoading.show(status: "Waiting...");
    user = auth.currentUser;
    await user.updateDisplayName(glo.name);
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
