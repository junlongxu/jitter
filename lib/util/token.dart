
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
class Token {
  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');
    return  prefs.getString('token');
    // if (token != null && token.isNotEmpty) {
    //   return token;
    // } else {
    //   return null;
    // }
  }

  static Future removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
