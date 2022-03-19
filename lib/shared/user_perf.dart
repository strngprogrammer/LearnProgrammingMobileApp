// @dart=2.9
import 'package:learnwithme/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userSave {
  // ignore: unused_field
  static SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLang(String language) async {
    await _preferences.setString('language', language);
  }

  static String getLang() => _preferences.getString('language');

  static String getLevel(
    String language,
  ) =>
      _preferences.getString('${language}_watched');
}
