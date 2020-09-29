import 'package:flutter/material.dart';
import 'package:jitter/model/follow_list.dart';
import 'package:jitter/model/user_info.dart';
import 'package:jitter/views/user_center/index.dart';
import 'package:jitter/widgets/button_widget.dart';
import 'package:jitter/widgets/list_tile_widget.dart';
import 'package:jitter/widgets/list_view_widget.dart';
import 'package:jitter/widgets/loading_widget.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/api/home.dart';

// ignore: must_be_immutable
class FoolowFansLike extends StatefulWidget {
  UserInfo userInfo;
  final Function callbackUserInfo;
  FoolowFansLike({this.callbackUserInfo, this.userInfo});
  @override
  _FoolowFansLikeState createState() => _FoolowFansLikeState();
}


class _FoolowFansLikeState extends State<FoolowFansLike> with Base {
  int focusPageNum = 1;
  List<FollowFansListItem> focusLists = new List();
  int fansPageNum = 1;
  List<FollowFansListItem> fansLists = new List();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _item(
              context: context,
              topNum: widget?.userInfo?.focusNum,
              bottomTitle: '关注',
              pageNum: focusPageNum,
              lists: focusLists,
              requestCb: _focusData,
              userId: widget?.userInfo?.userId),
          _item(
              context: context,
              topNum: widget?.userInfo?.fansNum,
              bottomTitle: '粉丝',
              pageNum: fansPageNum,
              lists: fansLists,
              requestCb: _fansData,
              userId: widget?.userInfo?.userId),
          _item(
              context: context,
              topNum: widget?.userInfo?.praiseNum,
              bottomTitle: '获赞',
              userId: widget?.userInfo?.userId,
              isJump: false),
        ],
      ),
    );
  }

  // 关注接口
  Future<FollowFans> _focusData(
      {int pageNum = 1, int pageSize = 10, String userId}) async {
    var data =
        await focusData(pageNum: pageNum, pageSize: pageSize, userId: userId);
    return data;
  }

  // 粉丝接口
  Future<FollowFans> _fansData(
      {int pageNum = 1, int pageSize = 10, String userId}) async {
    var data =
        await fansData(pageNum: pageNum, pageSize: pageSize, userId: userId);
    return data;
  }

  GestureDetector _item(
      {BuildContext context,
      dynamic topNum,
      String bottomTitle,
      String userId,
      int pageNum,
      List<FollowFansListItem> lists,
      Function requestCb,
      bool isJump = true}) {
    return GestureDetector(
      onTap: () {
        isJump
            ? NavigatorUtil.pushScale(
                context,
                Scaffold(
                  backgroundColor: themeColor,
                  appBar: AppBar(
                    backgroundColor: themeColor,
                    title: Text('TA的$bottomTitle'),
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // 重新渲染用户中心
                        widget.callbackUserInfo().then((UserInfo res) {
                          setState(() {
                            widget.userInfo = res;
                          });
                        });
                        // 直接清空防止用户操作过快
                        lists.clear();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  body: FutureBuilder<FollowFans>(
                    future: requestCb(pageNum: pageNum, userId: userId),
                    builder: (BuildContext futureBuilderContext,
                        AsyncSnapshot<FollowFans> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: themeColor,
                          child: LoadingWidget(
                            loadingType: LoadingType.ballSpin,
                            size: 30.0,
                          ),
                        );
                      } else if (snapshot.data != null &&
                          snapshot.data.list.length != 0) {
                        // 第一次添加
                        if (lists.length == 0) {
                          lists.addAll(snapshot.data.list);
                        }
                        return StatefulBuilder(
                          builder: (statefulBuilderContext, stateColumn) => Column(
                            children: <Widget>[
                              ListViewWidget(
                                callbackScroll: (Function _loading) {
                                  // 如果没有全部展示完
                                  if (lists.length <
                                      int.parse(snapshot?.data?.total)) {
                                    stateColumn(() {
                                      pageNum = ++pageNum;
                                      _loading();
                                    });
                                    // 滚动到底部添加懒加载
                                    requestCb(pageNum: pageNum, userId: userId)
                                        .then((FollowFans res) {
                                      stateColumn(() {
                                        lists.addAll(res.list);
                                        _loading();
                                      });
                                    }).catchError((err) {
                                      print(err);
                                    });
                                  }
                                },
                                dataList: lists,
                                callbackItem: _listTileItem,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            '还没有任何${bottomTitle}哦',
                            style: skyGraySmallTextStyle,
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            // ignore: unnecessary_statements
            : emptyWidget;
      },
      child: Column(
        children: <Widget>[
          Text(topNum.toString(),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          Text(bottomTitle, style: skyGraySmallTextStyle)
        ],
      ),
    );
  }

  Widget _listTileItem({FollowFansListItem item}) {
    // ValueNotifier<FollowFansListItem> _valueListenable =
    //     ValueNotifier<FollowFansListItem>(FollowFansListItem(attention: false));

    return ListTileWidget(
      page: UserCenter(
        userId: item.userId,
        callbackBtnStateFn: (attention) {
          setState(() {
            item.attention = attention;
          });
        },
      ),
      // page: ValueListenableBuilder(
      //   valueListenable: _valueListenable,
      //   builder:
      //       (BuildContext context, FollowFansListItem value, Widget child) {
      //     return UserCenter(
      //       userId: item.userId,
      //       callbackBtnStateFn: (attention) {
      //         setState(() {
      //           item.attention = attention;
      //         });
      //       },
      //     );
      //   },
      // ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          item.headImage,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        item?.nickName,
        style: largeTextStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.remark.length != 0 ? item?.remark : '暂无介绍',
            style: skyGraySmallTextStyle,
          ),
          Text(
            '粉丝 ${item.fansNum.toString()}',
            style: skyGraySmallTextStyle,
          ),
        ],
      ),
      trailing: Container(
        width: 90,
        height: 50,
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) state) =>
                  AnimatedSwitcherCounterRoute(
            showState: item.attention,
            // 如果是自己
            child: item.areSelf
                ? emptyWidget
                : ButtonWidget(
                    title: '关 注',
                    afterTitle: '已关注',
                    showState: !item.attention,
                    toastPopContext: context,
                    callback: () {
                      if (!item.attention) {
                        addFollowUsers(userId: item.userId).then(
                          (res) {
                            state(() {
                              item.attention = !item.attention;
                            });
                            showToast('关 注 成 功');
                          },
                        ).catchError((err) {});
                      } else {
                        delFollowUsers(userId: item.userId).then(
                          (res) {
                            state(() {
                              item.attention = !item.attention;
                            });
                            showToast('取 消 关 注');
                          },
                        );
                      }
                    },
                    width: 90,
                  ),
          ),
        ),
      ),
    );
  }
}
