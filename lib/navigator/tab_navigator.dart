import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitter/pages/camerapage/index.dart';
import 'package:jitter/pages/communitypage/index.dart';
import 'package:jitter/pages/login/components/show_model_sheet.dart';
import 'package:jitter/pages/homepage/index.dart';
import 'package:jitter/pages/login/index.dart';
import 'package:jitter/pages/mypage/index.dart';
import 'package:jitter/pages/startPage/index.dart';
import 'package:jitter/pages/taskpage/index.dart';

import 'package:jitter/util/base.dart';
import 'package:jitter/util/eventBus.dart';
// import 'package:jitter/util/custom_icons.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

const MethodChannel _nativeChannel =
    const MethodChannel('com.example.jitter/MainActivity');

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with Base {
  int _currentIndex = 0;
  bool isHome = true;
  bool isSplashPage = true;
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
    return GestureDetector(
      // onTap: () async {
      //   //调用原生下载
      //   // _nativeChannel.invokeMethod("apkdownLoad", "url": https://bt.5li2v2.com/channel/android/hqbetgame_6215472_2.0.2_0913213641.apk);
      //   setState(() {
      //     isSplashPage = false;
      //   });
      //   const url =
      //       'https://bt.5li2v2.com/channel/android/hqbetgame_6215472_2.0.2_0913213641.apk';
      //   if (await canLaunch(url)) {
      //     await launch(url);
      //   } else {
      //     throw 'Could not launch $url';
      //   }
      // },
      // child: isSplashPage ? SplashPage() : _scaffold,
      child: _scaffold,
    );
  }

  Widget get _scaffold => Scaffold(
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[...pages],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xff20242f),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          onTap: (index) {
            String token = SpUtil.prefs.getString('token');
            setState(() {
              if (index == 0 || token != null) {
                _controller.jumpToPage(index);
                setState(() {
                  _currentIndex = index;
                });
              }
              if (index != 0 && token != null) {
                VideoPlayerEvent
                    .controllers[VideoPlayerEvent.controllers.length - 1]
                    .pause();
              }
              if (index == 0) {
                VideoPlayerEvent
                    .controllers[VideoPlayerEvent.controllers.length - 1]
                    .play();
              }
              if (index != 0 && token == null) {
                ShowModelSheet.showLogin(context).then((res) {
                  setState(() {
                    _currentIndex = index;
                  });
                });
              }
            });
          },
          items: [
            _svgWidget('home', '首页', 0),
            _svgWidget('community', '社区', 1),
            _svgWidget('camera', '', 2),
            _svgWidget('task', '任务', 3),
            _svgWidget('my', '我的', 4)
          ],
        ),
      );

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
