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
    _tabController =
        new TabController(length: tabList.length, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            HomePosition(
              widget: _tabPageView(),
            ),
            HomePosition(
              top: 20.0,
              widget: _tabBarLabel(),
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

  _tabView(String name) {
    List<String> list = [
      'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_1453.MP4',
      'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_1458.MP4',
      'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1546.MP4',
      'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1969.MP4',
     
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

class HomePosition extends StatelessWidget {
  final double left;
  final double top;
  final double right;
  final double bottom;
  final Widget widget;
  const HomePosition(
      {Key key,
      this.left = 0,
      this.top = 0,
      this.right = 0,
      this.bottom = 0,
      @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left, right: right, top: top, bottom: bottom, child: widget);
  }
}
