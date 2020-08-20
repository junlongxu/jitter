import 'package:flutter/material.dart';

abstract class Base {
  final Color themeColor = Color(0xff242a37);
  final Color skyGray = Color(0xff727e99);
  final double boundarySize = 10.0;
  final TextStyle smallTextStyle =
      TextStyle(fontSize: 12, color: Color(0xffdedfe1));
  final TextStyle mediumTextStyle =
      TextStyle(fontSize: 14, color: Color(0xffdedfe1));
  final TextStyle largeTextStyle =
      TextStyle(fontSize: 16, color: Color(0xffdedfe1));
      final TextStyle maxTextStyle =
      TextStyle(fontSize: 16, color: Color(0xffdedfe1));
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
    @required Widget child,
    bool isCircular = false,
  }) =>
      Container(
        height: height,
        width: width,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(beginColor ?? 0xfff54b64),
            Color(endColor ?? 0xfff78361)
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius:
              BorderRadius.circular(isCircular ? (width ?? height / 2) : 20.0),
        ),
        child: child,
      );
}
