import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      child: Center(
        child: Text('敬请期待!'),
      ),
    );
  }
}
