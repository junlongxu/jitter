import 'package:flutter/material.dart';
import 'package:jitter/pages/camerapage/index.dart';
import 'package:jitter/pages/communitypage/index.dart';
import 'package:jitter/pages/homepage/index.dart';
import 'package:jitter/pages/login/index.dart';
import 'package:jitter/pages/mypage/index.dart';
import 'package:jitter/pages/taskpage/index.dart';

import 'package:jitter/util/base.dart';
import 'package:jitter/util/custom_icons.dart';
import 'package:jitter/util/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with Base {
  int _currentIndex = 0;
  bool isHome = true;
  final PageController _controller = PageController(initialPage: 0);
  final List<dynamic> pages = [
    HomePage(),
    CameraPage(),
    CommunityPage(),
    TaskPage(),
    MyPage()
  ];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            onTap: (index) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var token = prefs.getString('token');
              setState(() {
                if (index == 0 || token != null) {
                  _controller.jumpToPage(index);
                  setState(() {
                    _currentIndex = index;
                  });
                }
                if (index != 0 && token == null) {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext sheetContext) =>
                          LoginPage(currentIndex: _currentIndex, index: index));
                }
                // Token.removeToken();
              });
            },
            items: [
              _svgWidget('home', '首页', 0),
              _svgWidget('community', '社区', 1),
              _svgWidget('camera', '', 2),
              _svgWidget('task', '任务', 3),
              _svgWidget('my', '我的', 4)
            ]));
  }

  BottomNavigationBarItem _svgWidget(String img, String title, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset('assets/images/home/$img/invalid_name.png',
          width: img != 'camera' ? 25 : 45),
      activeIcon: Image.asset(
          'assets/images/home/$img${img != 'camera' ? '_active' : ''}/invalid_name.png',
          width: img != 'camera' ? 25 : 45),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 12,
            foreground: _currentIndex != index
                ? (Paint()
                  ..shader = textGradient(Color(0xff9c9ea3), Color(0xff9c9ea3)))
                : (Paint()
                  ..shader =
                      textGradient(Color(0xfff55363), Color(0xfff77d61))),
            decoration: TextDecoration.none),
      ),
    );
  }
}
