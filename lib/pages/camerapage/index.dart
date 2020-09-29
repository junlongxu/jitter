
import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with AutomaticKeepAliveClientMixin<CameraPage>, Base {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return MyHomePage(title: 'URL Launcher');
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(boundarySize),
      decoration: BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage('assets/images/camera/background/invalid_name.png'),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 300),
        child: Center(
          child: ButtonWidget(
            title: '立 即 加 入',
            height: 35,
            width: 200,
            callback: () async {
              const url = 'https://lynnconway.me/joinchat/I3sjb5A47QbtuOLafKJiPg';
              // const url = 'weixin://';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
              //在这里不能通过此方式获取FormState，context不对
              //print(Form.of(context));
              // 通过_formKey.currentState 获取FormState后，
              // 调用validate()方法校验用户名密码是否合法，校验
              // 通过后再提交数据。
            },
          ),
        ),
      ),
    );
    // return Container(
    //   color: themeColor,
    //   child: Center(
    //     child: GestureDetector(
    //       onTap: () {
    //         SpUtil.prefs.remove('token');
    //       },
    //       child: Text('清除token'),
    //     ),
    //   ),
    // );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
