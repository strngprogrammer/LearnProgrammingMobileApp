// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnwithme/screens/lesson_page.dart';
import 'package:learnwithme/shared/colors.dart';
import 'package:learnwithme/shared/side_menu.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/globals.dart' as glo;
import '../shared/user_perf.dart';

class LanguageLessons extends StatefulWidget {
  @override
  _LanguageLessonsState createState() => _LanguageLessonsState();
}

class _LanguageLessonsState extends State<LanguageLessons> {
  var user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MColors.backcolor,
        drawer: SideBar(),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: Stack(
          children: [
            Positioned(
              child: Lottie.asset('assets/img/waves.json'),
              bottom: -55,
              width: 500,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('${glo.langId}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      height: size.height,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Image.network(
                              glo.lessImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: snapshot.data!.docs.map((doc) {
                              return InkWell(
                                onTap: () {
                                  glo.lessImages = doc['images'];
                                  glo.lessTitle = doc['header'];

                                  glo.langId = glo.langId;

                                  try {
                                    glo.ytvideo = doc['yt'];
                                    glo.lessImages.add('youtube');
                                  } catch (e) {
                                    null;
                                  }

                                  setState(() {});

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const LessonPage()));
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        child: Text((int.parse(doc.id) + 1)
                                            .toString())),
                                    title: Text(
                                      doc['title'],
                                      style: GoogleFonts.cairo(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      doc['header'],
                                      style: GoogleFonts.cairo(fontSize: 12),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    );
                  }
                }),
          ],
        ));
  }
}
