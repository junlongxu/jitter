import 'package:flutter/material.dart';
import 'package:jitter/model/user_info.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/grid_view_widget.dart';
import 'package:jitter/widgets/img_item_widget.dart';

class WorksLikes extends StatefulWidget {
  final UserInfo userInfo;
  final Function callbackUserInfo;

  const WorksLikes({this.userInfo, this.callbackUserInfo});
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
        // indicatorColor: Colors.red,
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
    // return Container(
    //   child: Expanded(
    //     child: TabBarView(
    //         controller: _tabController,
    //         children: tabList.map<Widget>((value) => _tabView(value)).toList()),
    //   ),
    // );
    return MediaQuery.removePadding(
      // removeTop: true,
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
        ? GridViewWidget(
            gridList: gridList,
            callback: _imgItem,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          )
        : GridViewWidget(
            gridList: gridList.reversed.toList(),
            callback: _imgItem,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          );
  }

  Widget _imgItem(String imgUrl) {
    return ImgItemWidget(
      imgUrl: imgUrl,
      centerChild: Image.asset(
        'assets/images/home/play/invalid_name.png',
        height: 40,
        width: 40,
      ),
      bottomChild: Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: 0.6,
          child: Container(
            width: 200,
            height: 25,
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 0, 4, 2),
                  child: Image.asset(
                    'assets/images/home/love/invalid_name.png',
                    height: 14,
                    width: 14,
                  ),
                ),
                Text(
                  '123',
                  style: smallTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
