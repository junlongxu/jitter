import 'package:flutter/material.dart';
import 'package:jitter/widgets/web_view_widget.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebViewWidget(
          url:
              'http://www.11wy.top/taskpage/#/task?token=ed52c28cfa611694583d0f0c6feee417',
          statusBarColor: '242a37',
          title: 'H5',
          hideAppBar: true,
          bottomAppBar: true),
    );
  }
}
