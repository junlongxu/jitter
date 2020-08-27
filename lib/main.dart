import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '抖动app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // buttonTheme: new ButtonThemeData(
        //     minWidth: 0,
        //     height: 0,
        //     padding: EdgeInsets.all(0),
        //     buttonColor: Colors.transparent),
      ),
      home: Container(
        color: Color(0xff242a37),
        child: Media(),
      ),
    );
  }
}

class Media extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: TabNavigator(),
    );
  }
}
