import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  static String? getString(String key) {
    return sharedPreferences.getString(key);
  }


  static Future<void> setInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  static int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }


  static Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
