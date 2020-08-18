import 'package:flutter/material.dart';

abstract class Base {
  final Color themeColor = Color(0xff242a37);
  final Color skyGray = Color(0xff727e99);
  final double boundarySize = 16.0;
  Shader gradient(Color beginColor, Color endColor) => LinearGradient(
          colors: [beginColor, endColor],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight)
      .createShader(Rect.fromLTWH(0, 0, 1080, 1920));
}
