import 'package:flutter/material.dart';
import 'package:jitter/pages/mypage/components/user_top_msg.dart';
import 'package:jitter/util/base.dart';

import 'components/foolow_fans_like.dart';
import 'components/works_likes.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      padding: EdgeInsets.fromLTRB(boundarySize, 20, boundarySize, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[UserTopMsg(), FoolowFansLike(), WorksLikes()],
      ),
    );
  }
}
