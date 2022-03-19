import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learnwithme/screens/language_lessons.dart';
import 'package:learnwithme/shared/colors.dart';
import 'package:learnwithme/shared/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/globals.dart' as glo;
import 'package:learnwithme/shared/user_perf.dart';
import 'package:lottie/lottie.dart';

class UploadToDb extends StatefulWidget {
  @override
  _UploadToDbState createState() => _UploadToDbState();
}

class _UploadToDbState extends State<UploadToDb> {
  int idd = 0;
  List _images = [];
  List _langs = [
    {'id': 'ar', 'text': 'arabic'},
    {'id': 'en', 'text': 'english'}
  ];
  final TextEditingController _header = TextEditingController();
  final TextEditingController _how = TextEditingController();
  final TextEditingController _info = TextEditingController();
  final TextEditingController _more = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _yt = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _langid = TextEditingController();

  var _selectedlang = "english";

  void uploadit() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection(
            _selectedlang == "english" ? _langid.text : "ar_${_langid.text}")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    idd = _myDocCount.length;
    EasyLoading.show(status: 'loading...');
    var fire = FirebaseFirestore.instance
        .collection(
            _selectedlang == "english" ? _langid.text : "ar_${_langid.text}")
        .doc((idd).toString())
        .set({
      'title': _title.text,
      'header': _header.text,
      'info': _info.text,
      'more': _more.text,
      'how': _how.text,
      'yt': _yt.text,
      'images': _images
    }).then((value) =>
            {EasyLoading.showSuccess('Done Upload!'), EasyLoading.dismiss()});

    _images.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MColors.backcolor,
        drawer: SideBar(),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  margin:
                      EdgeInsets.only(bottom: 50, top: 10, left: 10, right: 10),
                  child: Lottie.asset('assets/img/anime.json'),
                ),
                textfield(
                    'language id',
                    _langid,
                    Icon(
                      Icons.language,
                      color: Colors.black,
                    )),
                textfield(
                    'title',
                    _title,
                    Icon(
                      Icons.title,
                      color: Colors.black,
                    )),
                textfield(
                    'header',
                    _header,
                    Icon(
                      Icons.text_fields,
                      color: Colors.black,
                    )),
                textfield(
                    'info',
                    _info,
                    Icon(
                      Icons.info,
                      color: Colors.black,
                    )),
                textfield(
                    'how',
                    _how,
                    Icon(
                      Icons.question_answer,
                      color: Colors.black,
                    )),
                textfield(
                    'more',
                    _more,
                    Icon(
                      Icons.more,
                      color: Colors.black,
                    )),
                textfield(
                    'youtube video',
                    _yt,
                    Icon(
                      Icons.link,
                      color: Colors.black,
                    )),
                textfield(
                    'image',
                    _image,
                    Icon(
                      Icons.image,
                      color: Colors.black,
                    )),
                myButton({_images.add(_image.text)}, "add photo"),
                Container(
                  width: 250,
                  child: DropdownButton(
                    hint: Text(
                      "select language",
                      style: TextStyle(color: Colors.white),
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.black,
                    value: _selectedlang,
                    items: _langs.map((e) {
                      return DropdownMenuItem<String>(
                          value: e['text'],
                          child: Text(e['text'],
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                              )));
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedlang = v.toString();
                      });
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
                  width: 250,
                  child: RaisedButton(
                    onPressed: () => uploadit(),
                    splashColor: Colors.indigoAccent,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text("upload lesson",
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Widget textfield(String placeh, TextEditingController controller, Icon icon) {
  return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
      width: 250,
      height: 50,
      child: TextField(
          controller: controller,
          obscureText: false,
          expands: true,
          minLines: null,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          cursorColor: Colors.black,
          style: GoogleFonts.cairo(textStyle: TextStyle(color: Colors.black)),
          autofocus: false,
          decoration: InputDecoration(
              prefixIcon: icon,
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
              hintText: placeh,
              hintStyle:
                  GoogleFonts.cairo(textStyle: TextStyle(color: Colors.black)),
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
                  borderSide: BorderSide(width: 0)))));
}

Widget myButton(void voi, String name) {
  return Container(
    margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
    width: 250,
    child: RaisedButton(
      onPressed: () => voi,
      splashColor: Colors.indigoAccent,
      color: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Text(name,
          style: GoogleFonts.mulish(
            color: Colors.white,
          )),
    ),
  );
}
