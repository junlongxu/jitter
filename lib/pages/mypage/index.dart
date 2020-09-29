import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/views/user_center/index.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:flutter/services.dart';

const MethodChannel _nativeChannel =
    const MethodChannel('com.example.jitter/MainActivity');

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: UserCenter(
          userId: SpUtil.prefs.getString('userId'),
          topChild: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _topIcon(
                  Icon(
                    Icons.insert_comment,
                    color: Colors.white,
                  ),
                  'message'
                ),
                _topIcon(
                  Icon(Icons.settings, color: Colors.white),
                  'setting'
                ),
              ],
            ),
          ),
          centerChild: new SizedBox(
            height: 200.0, //设置高度
            width: MediaQuery.of(context).size.width,
            child: new Card(
              color: themeColor,
              elevation: 15.0, //设置阴影
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
              child: Padding(
                padding: EdgeInsets.all(15),
                child: new Wrap(
                  spacing: 40.0, // 主轴(水平)方向间距
                  runSpacing: 20.0, // 纵轴（垂直）方向间距
                  alignment: WrapAlignment.start, //沿主轴方向居中
                  children: <Widget>[
                    _image('assets/images/my/balance/invalid_name.png', '我的余额',
                        'myBalance'),
                    _image('assets/images/my/coins/invalid_name.png', '我的金币',
                        'myCoins'),
                    _image('assets/images/my/friends/invalid_name.png', '邀请好友',
                        'invitedFriend'),
                    _image('assets/images/my/invitation_code/invalid_name.png',
                        '邀请码', 'invitedCode'),
                    _image('assets/images/my/help_center/invalid_name.png',
                        '帮助中心', 'help'),
                  ],
                ),
              ),
            ),
          ),
          isSelf: true),
    );
  }

  InkWell _topIcon(Widget child, String channelVal) {
    return InkWell(
      onTap: () {
        // 顶部信息和修改跳原生 跳原生 获取token使用SpUtil类 例: String token = SpUtil.prefs.getString('token');
        _startChannel(channelVal);
        // NavigatorUtil.pushCuper(
        //   context,
        //   Scaffold(
        //     backgroundColor: themeColor,
        //     appBar: AppBar(
        //       backgroundColor: themeColor,
        //     ),
        //     body: Center(
        //       child: Text(
        //         '功能开发中',
        //         style: largeTextStyle,
        //       ),
        //     ),
        //   ),
        // );
      },
      child: child,
    );
  }

  Future<void> _startChannel(String channelVal) async {
    _nativeChannel.invokeMethod(channelVal, {'token': SpUtil.prefs.getString('token')});
  }

  InkWell _image(String imgUrl, String title, String channelVal) {
    return InkWell(
      onTap: () {
        _startChannel(channelVal);
        // 顶部信息和修改跳原生 跳原生 获取token使用SpUtil类 例: String token = SpUtil.prefs.getString('token');

        // NavigatorUtil.pushCuper(
        //   context,
        //   Scaffold(
        //     backgroundColor: themeColor,
        //     appBar: AppBar(
        //       backgroundColor: themeColor,
        //     ),
        //     body: Center(
        //       child: Text(
        //         '功能开发中',
        //         style: largeTextStyle,
        //       ),
        //     ),
        //   ),
        // );
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            imgUrl,
            width: 35,
            height: 35,
            fit: BoxFit.fill,
          ),
          Text(
            title,
            style: smallTextStyle,
          )
        ],
      ),
    );
  }
}
