import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/admin/admin_upload.dart';
import 'package:learnwithme/auth/login.dart';
import 'package:learnwithme/screens/chose_language.dart';
import 'package:learnwithme/shared/dialog.dart';
import 'package:lottie/lottie.dart';
import '../shared/colors.dart';

var user = FirebaseAuth.instance;

class SideBar extends StatelessWidget {
  final List<dynamic> _buttons = [
    {
      "text": "logout",
      "icon": const Icon(Icons.logout, color: Colors.white),
      "id": "lo"
    },
    {
      "text": "language",
      "icon": const Icon(Icons.language, color: Colors.white),
      "id": "lang"
    },
    {
      "text": user.currentUser!.email == 'amar554503@gmail.com'
          ? "add lesson"
          : "about",
      "icon": user.currentUser!.email == 'amar554503@gmail.com'
          ? const Icon(
              Icons.add,
              color: Colors.white,
            )
          : const Icon(
              Icons.support,
              color: Colors.white,
            ),
      "id": user.currentUser!.email == 'amar554503@gmail.com' ? "add" : "about",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Stack(
          children: [
            Lottie.asset('assets/img/waves2.json', fit: BoxFit.fill),
            Container(
                color: MColors.color2,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 100),
                        child: Text(
                          "Good Day",
                          style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )),

                    // ignore: avoid_function_literals_in_foreach_calls
                    Column(
                      children: _buttons.map((e) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: FlatButton(
                            onPressed: () {
                              if (e['id'] == 'lo') {
                                user.signOut();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => LoginPage()));
                              } else if (e["id"] == 'lang') {
                                // TODO LANGUAGES PAGE

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ChoseLanguage()));
                              } else if (e['id'] == 'add') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UploadToDb()));
                              }
                            },
                            splashColor: Colors.white54,
                            child: Row(
                              children: [
                                e['icon'],
                                SizedBox(
                                  width: 15,
                                ),
                                Text(e['text'],
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ))
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
