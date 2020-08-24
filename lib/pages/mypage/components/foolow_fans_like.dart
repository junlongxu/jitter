import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class FoolowFansLike extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 平分一半屏幕
        children: <Widget>[
          _item('128', '关注'),
          _item('3120', '粉丝'),
          _item('5024', '获赞'),
        ],
      ),
    );
  }

  Column _item(String topTitle, String bottomTitle) => Column(
        children: <Widget>[
          Text(topTitle,
              style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w700)),
          Text(bottomTitle, style: skyGraySmallTextStyle),
        ],
      );
}
