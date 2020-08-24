import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/grid_view_widget.dart';
import 'package:jitter/widgets/player.dart';

class WorksLikes extends StatefulWidget {
  @override
  _WorksLikesState createState() => _WorksLikesState();
}

class _WorksLikesState extends State<WorksLikes>
    with Base, SingleTickerProviderStateMixin {
  final List<String> tabList = ['99作品', '128喜欢'];
  TabController _tabController;
  @override
  void initState() {
    _tabController =
        new TabController(length: tabList.length, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_tabBarLabel(), _tabPageView()],
      ),
    );
  }

// 顶部导航
  _tabBarLabel() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: _tabController,
        indicator: const BoxDecoration(),
        unselectedLabelColor: skyGray,
        tabs: <Widget>[
          ...tabList.map<Tab>((tab) => Tab(
                child: Text(
                  tab,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }

// 页面
  _tabPageView() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Expanded(
        child: TabBarView(
            controller: _tabController,
            children: tabList.map<Widget>((value) => _tabView(value)).toList()),
      ),
    );
  }

  _tabView(String name) {
    List gridList = [
      'https://img.mnmulu.com/upload/2020/01/28/jintianmeiying1035614.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2019/07/09/b4fb9fb83cea18d4b71c385897dae277.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2019/07/09/c2b335630da9a97f4d80b2d029153569.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2020/01/31/caicaixu1104040.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2019/07/09/b4fb9fb83cea18d4b71c385897dae277.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2019/07/09/c2b335630da9a97f4d80b2d029153569.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2020/01/31/caicaixu1104040.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
      'https://img.mnmulu.com/upload/2019/07/09/c2b335630da9a97f4d80b2d029153569.jpg.@ERESIZE@.mw_1000,qt_80.9c3e75.jpg.webp',
    ];
    return name != '99作品'
        ? GridViewWidget(gridList: gridList, callback: _imgItem)
        : GridViewWidget(
            gridList: gridList.reversed.toList(), callback: _imgItem);
  }

  Widget _imgItem(String imgUrl) {
    bool isPlayer = false;
    return GestureDetector(
      onTap: () {
        isPlayer = !isPlayer;
      },
      child: !isPlayer
          ? Container(
              height: 400,
              decoration: BoxDecoration(
                
                  image: DecorationImage(
                      image: NetworkImage(imgUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(4)),
              child: Stack(
                children: <Widget>[],
              ),
            )
          : Player(),
    );
  }
}
