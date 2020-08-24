import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class UserTopMsg extends StatefulWidget {
  @override
  _UserTopMsgState createState() => _UserTopMsgState();
}

class _UserTopMsgState extends State<UserTopMsg> with Base {
  @override
  Widget build(BuildContext context) {
    return _userMsg;
  }

  Widget get _userMsg => Row(
        // crossAxisAlignment: CrossAxisAlignment.center, // 都靠近顶部
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                      'https://pic2.zhimg.com/v2-5d2b3e4523ac5ee5cd3dbf435ced000e_xs.jpg?source=1940ef5c',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Allen',
                        style: maxTextStyle,
                      ),
                      Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: <Widget>[
                      _textBackground('山西'),
                      _textBackground('100岁'),
                      _textBackground('白羊座')
                    ],
                  ),
                  Text(
                    '个性签名: 做更加好的自己',
                    style: skyGraySmallTextStyle,
                  )
                ],
              ),
            ],
          ),
          _rightButton
        ],
      );
  Widget get _rightButton => containerGradient(
      width: 60,
      height: 30,
      child: Text(
        '关注',
        style: mediumTextStyle,
      ));
  Widget _textBackground(String title) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 20,
      // padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        title,
        style: smallTextStyle,
      ),
    );
  }
}
