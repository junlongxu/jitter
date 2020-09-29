import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static void pushCuper(BuildContext context, Widget page) {
     Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }

  static void pushDefault(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
  static void pushScale(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                  child: page,
                )));
  }
}
