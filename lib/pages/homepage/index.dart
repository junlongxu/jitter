import 'package:flutter/material.dart';
import 'package:jitter/api/home.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/pages/login/components/show_model_sheet.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/views/player_item/index.dart';
import 'package:jitter/widgets/button_widget.dart';
import 'package:jitter/widgets/grid_view_widget.dart';
import 'package:jitter/widgets/img_item_widget.dart';
import 'package:jitter/widgets/player.dart';

const String DEFALUT_URL =
    'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080514/1290895585221619714/mp4/134.mp4';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Base, SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int truePageNum = 1;
  // 视频列表
  List<VideosListItem> videosList = new List();
  final List<String> tabList = ['关注', '推荐', '直播'];
  TabController _tabController;

  // 页面重绘
  @override
  void initState() {
    _tabController =
        new TabController(length: tabList.length, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Stack(
          children: <Widget>[
            HomePosition(
              child: _tabPageView,
            ),
            HomePosition(
              top: 40.0,
              child: _tabBarLabel,
            ),
            HomePosition(
              top: 52.0,
              left: 20,
              child: _serchIcon,
            ),
          ],
        ),
      ),
    );
  }

  Container get _serchIcon => Container(
        alignment: Alignment.topLeft,
        child: Icon(Icons.search, color: Colors.white, size: 24),
      );

// 顶部导航
  Container get _tabBarLabel => Container(
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

// 页面
  TabBarView get _tabPageView => TabBarView(
      controller: _tabController,
      children: tabList.map<Widget>((value) => _tabView(value)).toList());

  Widget _tabView(String name) {
    // var token = Token.getToken();
    Widget page;
    if (name == '推荐') {
      page = _recommend;
    } else if (name == '关注') {
      page = _followView;
    } else {
      page = _liveBroadcast;
    }
    return page;
  }

  Player get _liveBroadcast => Player(
      videoIdcUrl:
          'http://www.akixr.top:9000/bucket1-uat/VIDEOS/2020091011/1288474681849995266/mp4/kkk.m3u8',
      videoImg: 'widget.item.videoImg');
  FutureBuilder get _recommend => FutureBuilder<VideosModel>(
        future: _getVideos(truePageNum),
        builder: (BuildContext context, AsyncSnapshot<VideosModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              videosList.length == 0) {
            return Container(
              color: Colors.black,
              child: Text('data'),
            );
          } else if (snapshot.data != null) {
            videosList.addAll(snapshot.data.list);
            return PageView.builder(
                itemCount: videosList?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (index == (videosList.length - 2).floor()) {
                    _getVideos(++truePageNum).then((VideosModel res) {
                      setState(() {
                        videosList.addAll(res.list);
                      });
                    });
                  }
                  return PlayerItem(
                    item: videosList[index],
                  );
                });
          }
        },
      );

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
  Widget get _followView => SpUtil.prefs.getString('token') != null
      ? Container(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: GridViewWidget(
            gridList: gridList,
            callback: _imgItem,
            count: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        )
      : Center(
          child: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text('你还没有登录', style: maxTextStyle),
                Text(
                  '登录用户查看你关注的精彩内容',
                  style: skyGraySmallTextStyle,
                ),
                ButtonWidget(
                  title: '登 录',
                  width: 300,
                  height: 40,
                  margin: EdgeInsets.only(top: 50),
                  callback: () {
                    ShowModelSheet.showLogin(context).then((res) {
                      var isShow = false;
                      setState(() {
                        isShow = !isShow;
                      });
                    });
                  },
                )
              ],
            ),
          ),
        );

  Future<VideosModel> _getVideos([int pageNum = 1, int pageSize = 10]) async {
    var videoData = await getVideos(pageNum: pageNum, pageSize: pageSize);
    return videoData;
  }

  Widget _imgItem(String imgUrl) {
    return ImgItemWidget(
      imgUrl: imgUrl,
      bottomChild: Positioned(
          bottom: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                      'https://pic2.zhimg.com/v2-5d2b3e4523ac5ee5cd3dbf435ced000e_xs.jpg?source=1940ef5c',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 168,
                color: Colors.black.withOpacity(0.1),
                padding: EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '@色情网',
                      style: mediumTextStyle,
                    ),
                    Text(
                      '16小时',
                      style: mediumTextStyle,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePosition extends StatelessWidget {
  final double left;
  final double top;
  final double right;
  final double bottom;
  final Widget child;
  const HomePosition(
      {Key key,
      this.left = 0,
      this.top = 0,
      this.right = 0,
      this.bottom = 0,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left, right: right, top: top, bottom: bottom, child: child);
  }
}
