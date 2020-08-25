import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var aaa = prefs.getString('token').toString();
    return null;
  }

  static removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
