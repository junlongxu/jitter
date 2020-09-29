import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with Base {

  //与原生通信,与原生保持一致
  static const MethodChannel _channel = const MethodChannel('com.example.jitter/MainActivity');

  @override
  void initState() {
    super.initState();
    _startShoot();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      child: Center(
        child: RaisedButton(
          onPressed: () {
            SpUtil.prefs.remove('token');
          },
          child: Text('清除token'),
        ),
      ),
    );
  }

  Future<void> _startShoot() async {
    //传入token参数
    _channel.invokeMethod('startShoot',{ "token" : SpUtil.prefs.getString('token')});
  }
}
