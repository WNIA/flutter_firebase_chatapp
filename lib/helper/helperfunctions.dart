import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPrefUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefUserNameKey = "USERNAMEKEY";
  static String sharedPrefUserEmailKey = "USEREMAILKEY";

  //saving data to SharedPreferences

  static Future<bool> saveUserLoggedInSharedPref(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefUserLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveUserNameSharedPref(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserNameKey, userName);
  }
  static Future<bool> saveUserEmailSharedPref(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserEmailKey, userEmail);
  }

  //getting data from SharedPreferences
  static Future<bool> getUserLoggedInSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPrefUserLoggedInKey);
  }
  static Future<String> getUserNameSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefUserNameKey);
  }
  static Future<String> getUserEmailSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefUserEmailKey);
  }
}