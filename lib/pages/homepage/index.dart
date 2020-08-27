import 'package:flutter/material.dart';
import 'package:jitter/api/home.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/player.dart';

import 'components/comment_avatar.dart';
import 'components/share_love_message.dart';

const String DEFALUT_URL =
    'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080514/1290895585221619714/mp4/134.mp4';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Base, SingleTickerProviderStateMixin {
  int truePageNum = 1;
  // 视频列表
  List<VideosListItem> videosList = new List();
  // List<String> videoList = [
  //     'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_1453.MP4',
  //     'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_1458.MP4',
  //     'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1546.MP4',
  //     'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1969.MP4',
  //   ];
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
      child: Scaffold(
        backgroundColor: themeColor,
        body: Stack(
          children: <Widget>[
            HomePosition(
              child: _tabPageView(),
            ),
            HomePosition(
              top: 20.0,
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

  _tabView(String name) {
    return name != '推荐'
        ? Center(
            child: Text(
              '敬请期待 !',
              style: maxTextStyle,
            ),
          )
        : FutureBuilder<VideosModel>(
            future: _getVideos(truePageNum),
            builder:
                (BuildContext context, AsyncSnapshot<VideosModel> snapshot) {
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
                      if (index == (videosList.length * 0.8).floor()) {
                        _getVideos(++truePageNum).then((VideosModel res) {
                          setState(() {
                            videosList.addAll(res.list);
                          });
                          print(videosList);
                        });
                      }
                     
                      return Container(
                        height: 300,
                        width: 300,
                        child: Stack(
                          children: <Widget>[
                            Player(item: videosList[index]),
                            HomePosition(
                              top: MediaQuery.of(context).size.height * 0.7,
                              left: 10,
                              child: CommentAvatar(item: videosList[index]),
                            ),
                            HomePosition(
                              top: MediaQuery.of(context).size.height * 0.35,
                              left: MediaQuery.of(context).size.width * 0.8,
                              child: ShareLoveMessage(item: videosList[index]),
                            ),
                          ],
                        ),
                      );
                    });
              }
            });
  }

  Future<VideosModel> _getVideos([int pageNum = 1, int pageSize = 10]) async {
    var videoData = await getVideos(pageNum: pageNum, pageSize: pageSize);
    return videoData;
  }
  // @override
  // bool get wantKeepAlive => true;
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
