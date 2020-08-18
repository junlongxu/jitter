import 'package:flutter/material.dart';

class NavigatorUtil {
  static push(BuildContext context, Widget page) {
    MaterialPageRoute(builder: (context) => page);
  }
}
