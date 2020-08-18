import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jitter/pages/camera_page.dart';
import 'package:jitter/pages/community_page.dart';
import 'package:jitter/pages/home_page.dart';
import 'package:jitter/pages/my_page.dart';
import 'package:jitter/pages/task_page.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/custom_icons.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: PageView(
    //     children: <Widget>[],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _currentIndex,
    //     items: [
    //       _svgWidget(CustomIcons.home, '首页', HomePage()),
    //       _svgWidget(CustomIcons.community, '社区', CommunityPage()),
          
    //       _svgWidget(CustomIcons.camera, '', CameraPage()),
    //       _svgWidget(CustomIcons.task, '任务', TaskPage()),
    //       _svgWidget(CustomIcons.my, '我的', MyPage())
    //     ],
    //   ),
    // );
    return Container(
      height: 50,
      // color: Color(0xff20242f),
      child: Stack(
        children: <Widget>[
          // PageView(),
          Positioned(
            // bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _svgWidget(CustomIcons.home, '首页', HomePage()),
                _svgWidget(CustomIcons.community, '社区', CommunityPage()),
                _svgWidget(CustomIcons.camera, '', CameraPage()),
                _svgWidget(CustomIcons.task, '任务', TaskPage()),
                _svgWidget(CustomIcons.my, '我的', MyPage())
              ],
            ),
          )
        ],
      ),
    );
  }

  // BottomNavigationBarItem  _svgWidget(IconData icon, String title, page) => BottomNavigationBarItem(
  //   icon: Icon(icon)
  // ); 
  Widget _svgWidget(IconData icon, String title, page) {
    // 渐变效果设置
    Gradient gradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xfff55363), Color.fromARGB(246, 121, 97, 1)]);
    //根据gradient 创建shader
    Shader shader = gradient.createShader(Rect.fromLTWH(0, 0, 1080, 1920));
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, page);
      },
      child: Column(
        children: <Widget>[
          title == ''
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xfff55363), Color(0xfff77d61)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              : Icon(icon,
                  color: Colors.red,
                  size: 26,
                  textDirection: TextDirection.rtl),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                foreground: Paint()..shader = shader,
                decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }
}
