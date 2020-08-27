import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'dart:async';
import 'package:jitter/widgets/web_view_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with Base, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =
        prefs.getString('token') == null ? '' : prefs.getString('token');
    return token;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Expanded(
          flex: 1,
          child: FutureBuilder<String>(
            future: getToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    // color: Colors.red,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(image: AssetImage('assets/images/task/mask/invalid_name.png'), fit: BoxFit.cover)
                    // ),
                    );
              } else if (snapshot.data != null) {
                return WebViewWidget(
                  url:
                      'http://www.11wy.top/taskpage/#/task?token=${snapshot.data}',
                  // url: 'http://172.24.136.31:8012/#/task?token=ae97f698acafaf97c6007ed46b3e413a',
                );
              }
            },
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
