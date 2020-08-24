import 'package:flutter/material.dart';
import 'package:jitter/pages/login/index.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoginPage(),
    );
  }
}
