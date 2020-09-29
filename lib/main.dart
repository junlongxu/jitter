import 'package:flutter/material.dart';
import 'navigator/tab_navigator.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:jitter/util/sp_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
  try {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  } catch (err) {
    print(err);
  }
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-" + success.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: '抖动app',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'San Francisco font(SF)',
        // buttonTheme: new ButtonThemeData(
        //     minWidth: 0,
        //     height: 0,
        //     padding: EdgeInsets.all(0),
        //     buttonColor: Colors.transparent),
      ),
      home: Container(
          color: Color(0xff242a37),
          // color: Colors.transparent,
          child: Media()),
    );
  }
}

class Media extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      // padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: TabNavigator(),
    );
  }
}
