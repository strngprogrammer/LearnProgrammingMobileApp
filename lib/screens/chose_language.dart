import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnwithme/shared/colors.dart';
import 'package:learnwithme/shared/dialog.dart';
import 'package:learnwithme/shared/user_perf.dart';
import 'package:learnwithme/globals.dart' as glo;

class ChoseLanguage extends StatelessWidget {
  const ChoseLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.backcolor,
      appBar: AppBar(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    userSave.setLang('ar');
                    glo.language = 'ar';
                    openDialog('language', 'تم تحديث اللغة', context);
                  },
                  splashColor: Colors.amber,
                  child: Text(" 🇸🇦  العربية",
                      style: GoogleFonts.cairo(
                        fontSize: 25,
                        color: Colors.white,
                      ))),
              InkWell(
                  onTap: () {
                    userSave.setLang('en');
                    glo.language = 'en';
                    openDialog('language', 'langauge updated !', context);
                  },
                  splashColor: Colors.amber,
                  child: Text("🇬🇧 ENGLISH",
                      style: GoogleFonts.cairo(
                        fontSize: 25,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
