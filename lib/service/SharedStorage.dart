import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  //Selected Country
  static String selectedCountry = '';
  static String lastRefresh = 'time';

  //SAVING DATA TO SHARED PREFERENCE
  static Future<bool> saveSelectedCountry(String country) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(selectedCountry, country);
  }

  static Future<String?> getCurrentCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(selectedCountry);
  }
  //SAVING DATA TO SHARED PREFERENCE
  static Future<bool> saveLastRefresh(DateTime minutes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lastRefresh, minutes.toString());
  }

  static Future<String?> getLastRefresh() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(lastRefresh);
  }
}
