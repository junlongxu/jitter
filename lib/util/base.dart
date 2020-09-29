import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Base {
  final Color themeColor = Color(0xff242a37);
  final Color skyGray = Color(0xff727e99);
  final double boundarySize = 10.0;

  final TextStyle skyGraySmallTextStyle = TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
      color: Color(0xff727e99),
      fontWeight: FontWeight.w500);

  final TextStyle smallTextStyle = TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
      color: Color(0xffdedfe1),
      fontWeight: FontWeight.w500);
  final TextStyle mediumTextStyle = TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      color: Color(0xffdedfe1),
      fontWeight: FontWeight.w500);
  final TextStyle largeTextStyle = TextStyle(
      fontSize: 16,
      decoration: TextDecoration.none,
      color: Color(0xffdedfe1),
      fontWeight: FontWeight.w500);
  final TextStyle maxTextStyle = TextStyle(
      fontSize: 18, color: Color(0xffdedfe1), fontWeight: FontWeight.w500);
  Shader textGradient(Color beginColor, Color endColor) => LinearGradient(
          colors: [beginColor, endColor],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight)
      .createShader(Rect.fromLTWH(0, 0, 1080, 1920));

  Container containerGradient({
    Color beginColor,
    Color endColor,
    double width,
    @required double height,
    EdgeInsets padding,
    EdgeInsets margin,
    @required Widget child,
    bool isCircular = false,
  }) =>
      Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(beginColor ?? 0xfff54b64),
            Color(endColor ?? 0xfff78361)
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius:
              BorderRadius.circular(isCircular ? (width ?? height / 2) : 25.0),
        ),
        child: child,
      );
  get emptyWidget => Container(width: 0, height: 0);

  EdgeInsets mediaPadding(context) => MediaQuery.of(context).padding;

  void showToast(
    String text, {
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff20242f),
        textColor: Colors.white,
        fontSize: 12.0);
  }
}
