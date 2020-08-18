import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff000000),
      child: Player(url: 'https://media.w3.org/2010/05/sintel/trailer.mp4',),
    );
  }
}
