import 'package:flutter/material.dart';
import 'package:jitter/pages/camerapage/index.dart';
import 'package:jitter/pages/communitypage/index.dart';
import 'package:jitter/pages/homepage/index.dart';
import 'package:jitter/pages/mypage/index.dart';
import 'package:jitter/pages/taskpage/index.dart';

import 'package:jitter/util/base.dart';
import 'package:jitter/util/custom_icons.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with Base {
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  final List pages = [
    HomePage(),
    CameraPage(),
    CommunityPage(),
    MyPage(),
    TaskPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[...pages],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff20242f),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              _svgWidget(CustomIcons.home, '首页', 0),
              _svgWidget(CustomIcons.community, '社区', 1),
              _svgWidget(CustomIcons.camera, '', 2),
              _svgWidget(CustomIcons.task, '任务', 3),
              _svgWidget(CustomIcons.my, '我的', 4)
            ]));
  }

  BottomNavigationBarItem _svgWidget(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: title == ''
            ? containerGradient(
                isCircular: true,
                width: 40,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ))
            : Icon(icon,
                color: Colors.white,
                size: 26,
                textDirection: TextDirection.rtl),
        activeIcon: title == ''
            ? containerGradient(
                child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ))
            : Icon(icon,
                color: Color(0xffdd685c),
                size: 26,
                textDirection: TextDirection.rtl),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 12,
              foreground: _currentIndex != index
                  ? (Paint()
                    ..shader =
                        textGradient(Color(0xff9c9ea3), Color(0xff9c9ea3)))
                  : (Paint()
                    ..shader =
                        textGradient(Color(0xfff55363), Color(0xfff77d61))),
              decoration: TextDecoration.none),
        ));
  }
}
