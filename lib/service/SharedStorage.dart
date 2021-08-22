import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  static String selectedCountry = '';
  static String lastRefresh = 'time';
  static String themeValue = '0';

  //? To Save selected Country to shared prefs
  //SAVING DATA TO SHARED PREFERENCE
  static Future<bool> saveSelectedCountry(String country) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(selectedCountry, country);
  }

  //? To get selected Country from shared prefs
  static Future<String?> getCurrentCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(selectedCountry);
  }

  //? To Save last Refresh Time to shared prefs
  //SAVING DATA TO SHARED PREFERENCE
  static Future<bool> saveLastRefresh(DateTime minutes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lastRefresh, minutes.toString());
  }

  //? To get last Refresh Time from shared prefs
  static Future<String?> getLastRefresh() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(lastRefresh);
  }

  //? To Save Selected theme to shared prefs
  //SAVING DATA TO SHARED PREFERENCE
  static Future<bool> saveSelectedTheme({required int value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(themeValue, value);
  }

  //? To get selected theme from shared prefs
  static Future<int?> getCurrentTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(themeValue);
  }
}
