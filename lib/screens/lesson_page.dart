import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/shared/colors.dart';
import 'package:learnwithme/shared/side_menu.dart';
import 'package:learnwithme/globals.dart' as glo;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(glo.ytvideo).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: false,
      ));

  @override
  // ignore: must_call_super
  void dispose() {
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MColors.backcolor,
        drawer: SideBar(),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('${glo.langId}')
                .where('header', isEqualTo: glo.lessTitle)
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
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          width: size.width,
                          height: 200,
                          child: CarouselSlider(
                            items: (glo.lessImages
                                .map((e) => e == 'youtube'
                                    ? YoutubePlayerBuilder(
                                        player: YoutubePlayer(
                                          controller: _controller,
                                          showVideoProgressIndicator: true,
                                        ),
                                        builder:
                                            (BuildContext context, player) {
                                          return player;
                                        },
                                      )
                                    : Container(
                                        margin: const EdgeInsets.all(5),
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(e),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))
                                .toList()),
                            options: CarouselOptions(
                                initialPage: 0,
                                viewportFraction: 0.8,
                                height: 180,
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 5),
                                autoPlay: false,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true),
                          ),
                        ),
                        Column(
                            children: snapshot.data!.docs.map((doc) {
                          return Card(
                            child: Container(
                              width: size.width - 20,
                              padding: EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: GoogleFonts.cairo(
                                        fontSize: 24, color: Colors.black),
                                  ),
                                  Text(
                                    doc['header'],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                        fontSize: 22, color: Colors.deepOrange),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Info",
                                    style: GoogleFonts.cairo(
                                        fontSize: 24, color: Colors.black),
                                  ),
                                  Text(
                                    doc['info'],
                                    style: GoogleFonts.cairo(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "how?",
                                    style: GoogleFonts.cairo(
                                        fontSize: 24, color: Colors.black),
                                  ),
                                  Text(
                                    doc['how'],
                                    style: GoogleFonts.cairo(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    doc['more'],
                                    style: GoogleFonts.cairo(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList())
                      ]),
                    ));
              }
            }));
  }
}
