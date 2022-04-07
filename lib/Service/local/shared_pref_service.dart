import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService{
  // ----save shared pref----
  void setStringSharedPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //----get shared pref---
  Future<String> getStringSharedPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value.toString();
  }

  //----remove shared pref----
  Future removeSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('removed');
    prefs.clear();
  }
}