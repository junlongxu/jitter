import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Base, SingleTickerProviderStateMixin {
  final List<String> tabList = ['关注', '推荐'];
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: tabList.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      // child: Player(
      //   url: 'http://www.w3school.com.cn/example/html5/mov_bbb.mp4',
      // ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: _tabPageView(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 20,
              child: _tabBarLabel(),
            ),
          ],
        ),
      ),
    );
  }

// 顶部导航
  _tabBarLabel() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3.0,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: <Widget>[
          ...tabList.map<Tab>((tab) => Tab(
                child: Text(
                  tab,
                  style: TextStyle(fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }

// 页面
  _tabPageView() {
    return TabBarView(
        controller: _tabController,
        children: tabList.map<Widget>((value) => _tabView(value)).toList());
  }

  _tabBar() {
    return Text('data');
  }

  _tabView(String name) {
    List<String> list = [
      'http://www.w3school.com.cn/example/html5/mov_bbb.mp4',
      'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4',
      'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4'
    ];
    return name != '推荐'
        ? Icon(
            Icons.ac_unit,
            color: Colors.white,
          )
        : PageView.builder(
            itemCount: list?.length ?? 0,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Player(url: list[index]);
            });
  }
  // @override
  // bool get wantKeepAlive => true;
}
