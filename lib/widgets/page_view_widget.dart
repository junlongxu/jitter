import 'package:flutter/material.dart';

GlobalKey<_PageViewWidgetState> childKey = GlobalKey();
class PageViewWidget extends StatefulWidget {
  final List<String> tabList;
  final Function tabView;
  const PageViewWidget({Key key, this.tabList, this.tabView}) : super(key: key);
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(
        length: widget?.tabList?.length, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('PageViewWidget');
  }

// 顶部导航
  Container _tabBarLabel() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3.0,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: <Widget>[
          ...widget?.tabList?.map<Tab>((tab) => Tab(
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
  TabBarView tabPageView() {
    return TabBarView(
        controller: _tabController,
        children: widget?.tabList
            ?.map<Widget>((value) => widget?.tabView(value))
            ?.toList());
  }
}
