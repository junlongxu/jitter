import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/web_view_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with Base, AutomaticKeepAliveClientMixin {
  var token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  Future<Null> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') == null ? '' : prefs.getString('token');
    });
    print(token);
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebViewWidget(
          // 5450e83c1a2f4d79f5c05330c258c520
          url: 'http://www.11wy.top/taskpage/#/task?token=$token',
          // url: 'http://172.24.135.208/taskpage/#/task?token=$token',
          statusBarColor: '242a37',
          title: 'H5',
          hideAppBar: true,
          bottomAppBar: false),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
