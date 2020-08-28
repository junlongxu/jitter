import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      child: Center(
        child: Text('敬请期待'),
      ),
    );
  }
}
