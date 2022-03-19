import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learnwithme/screens/language_lessons.dart';
import 'package:learnwithme/shared/colors.dart';
import 'package:learnwithme/shared/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/globals.dart' as glo;
import 'package:learnwithme/shared/user_perf.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MColors.backcolor,
      drawer: SideBar(),
      appBar: AppBar(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                child: Lottie.asset('assets/img/waves.json'),
                bottom: -55,
                width: 500,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    "Languages",
                    style: GoogleFonts.cairo(color: Colors.white, fontSize: 24),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('languages')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: SpinKitSquareCircle(
                            itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven ? Colors.blue : Colors.white,
                            ),
                          );
                        }));
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: SpinKitSquareCircle(
                              itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    index.isEven ? Colors.blue : Colors.white,
                              ),
                            );
                          }));
                        default:
                          return Expanded(
                              child: Container(
                                  margin: const EdgeInsets.all(15),
                                  child: GridView.count(
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2,
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          margin: const EdgeInsets.all(5),
                                          child: Stack(
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                onTap: () {
                                                  var ll = userSave.getLang();
                                                  if (ll == 'ar') {
                                                    glo.language = 'ar';
                                                    glo.langId =
                                                        'ar' + document['id'];
                                                  } else {
                                                    glo.language == 'en';
                                                    glo.langId = document['id'];
                                                  }

                                                  glo.lessImage =
                                                      document['image'];
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              LanguageLessons()));
                                                },
                                                splashColor:
                                                    Colors.indigoAccent,
                                                child: Container(
                                                    width: 170,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            document['image']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                right: 5,
                                                child: Text(document['text'],
                                                    style: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            Colors.black54)),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList())));
                      }
                    })
              ]),
            ],
          )),
    );
  }
}
