import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
    );
  }
}
