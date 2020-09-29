import 'dart:ui';
import 'package:jitter/model/share.dart';
import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/pages/login/components/show_model_sheet.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/views/player_item/components/share.dart';
import 'package:jitter/widgets/loading_widget.dart';

import 'package:jitter/widgets/list_view_widget.dart';
import 'package:jitter/dart/bottomSheet.dart' as CustomBottomSheet;

class ShareLoveMessage extends StatefulWidget {
  final VideosListItem item;
  const ShareLoveMessage({this.item});
  @override
  _ShareLoveMessageState createState() => _ShareLoveMessageState();
}

class _ShareLoveMessageState extends State<ShareLoveMessage> with Base {
  bool loveState = false;
  bool shareLoveState = false;
  String inputValue = '';
  var backfillUserData;
  String replyShareValue = ''; // 回复评论
  String token = SpUtil.prefs.getString('token');
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = backfillUserData?.nickname != ''
        ? '回复${backfillUserData?.nickname}'
        : '说点什么吧 !';

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Align build(BuildContext context) {
    return Align(
        // widthFactor: 100.0,
        alignment: Alignment.bottomRight,
        child: Container(
          width: 50,
          padding: EdgeInsets.only(right: 10, bottom: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (token != null) {
                        loveState = !loveState;
                        if (loveState) {
                          widget?.item?.praiseNum++;
                        } else {
                          widget?.item?.praiseNum--;
                        }
                      } else {
                        ShowModelSheet.showLogin(context);
                      }
                    });
                  },
                  child: AnimatedSwitcherCounterRoute(
                    showState: loveState,
                    child: _loveContainer(
                        !loveState
                            ? 'assets/images/home/love/invalid_name.png'
                            : 'assets/images/home/love_active/invalid_name.png',
                        widget?.item?.praiseNum),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Stack(
                  children: <Widget>[
                    _loveContainer(
                        'assets/images/home/information/invalid_name.png',
                        widget?.item?.commentNum),
                    FloatingActionButton(
                      onPressed: _showModalBottomSheet,
                      elevation: 0.0,
                      highlightElevation: 0.01,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (token == null) {
                      ShowModelSheet.showLogin(context);
                    } else {
                      NavigatorUtil.pushCuper(
                        context,
                        Scaffold(
                          backgroundColor: themeColor,
                          appBar: AppBar(
                            backgroundColor: themeColor,
                          ),
                          body: Share(item: widget.item),
                        ),
                      );
                    }
                  },
                  child: _loveContainer(
                      'assets/images/home/share/invalid_name.png', '分享')),
            ],
          ),
        ));
  }

  // 底部弹框
  Future _showModalBottomSheet() {
    var data = {
      "total": "3",
      "list": [
        {
          "id": "1296065391553949698",
          "parentId": "0",
          "headImg":
              "http://img.touxiangwu.com/uploads/allimg/200312/-1_031215303CB6.jpg",
          "userId": "1296063479924404226",
          "nickname": "心飞扬电子",
          "content": " 回复 孤者何惧: 人都不服就服这个杆子的弹性!",
          "commentDate": "20:44",
          "praiseNum": "0",
          "replyNum": "1",
          "child": [
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_03121411131Q5.jpg",
              "userId": "1296063479924404226",
              "nickname": "一起发呆吧",
              "content": "不你还有服他的臂力 ! ",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_0312141122HV.jpg",
              "toReplyUserName": "Dream",
              "commentId": "1296065391553949698",
              "isPraise": 2
            },
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_031215402Y235.jpg",
              "userId": "1296063479924404226",
              "nickname": "相叶不念世",
              "content": "无线循环之大傻吊 !",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_031210552G5W.jpg",
              "toReplyUserName": "罗伟泽964",
              "commentId": "1296065391553949698",
              "isPraise": 1
            },
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_03121055191c9.jpg",
              "userId": "1296063479924404226",
              "nickname": "Dream",
              "content": "确实好厉害!!!",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_03121055234148.jpg",
              "toReplyUserName": "心飞扬电子",
              "commentId": "1296065391553949698",
              "isPraise": 0
            },
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_0312105522U23.jpg",
              "userId": "1296063479924404226",
              "nickname": "千杯不醉",
              "content": "转发.@这不是一个普普通通的男人!!!",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://img.touxiangwu.com/uploads/allimg/200312/-1_03121055203142.jpg",
              "toReplyUserName": "心飞扬电子",
              "commentId": "1296065391553949698",
              "isPraise": 0
            }
          ],
          "videoId": "1295362901732765698",
          "commentId": "1296065391553949698",
          "isPraise": 63
        },
        {
          "id": "1296063705758314497",
          "parentId": "0",
          "headImg":
              "http://img.touxiangwu.com/uploads/allimg/200312/-1_03121055191416.jpg",
          "userId": "1296063479924404226",
          "nickname": "孤者何惧",
          "content": "不就是一个典型的视觉误差么 ",
          "commentDate": "20:37",
          "praiseNum": "0",
          "replyNum": "0",
          "child": [],
          "videoId": "1295362901732765698",
          "commentId": "1296063705758314497",
          "isPraise": 3
        },
        {
          "id": "1296063705758314497",
          "parentId": "0",
          "headImg":
              "http://img.touxiangwu.com/uploads/allimg/200313/-1_031311512C039.jpg",
          "userId": "1296063479924404226",
          "nickname": "打劫(网易必胜)",
          "content": "还是跟我上次说的一样, 盯着中间就会像圆形. ",
          "commentDate": "20:37",
          "praiseNum": "0",
          "replyNum": "0",
          "child": [],
          "videoId": "1295362901732765698",
          "commentId": "1296063705758314497",
          "isPraise": 1
        },
        {
          "id": "1296063705758314497",
          "parentId": "0",
          "headImg":
              "http://img.touxiangwu.com/uploads/allimg/200312/-1_031215422KU6.jpg",
          "userId": "1296063479924404226",
          "nickname": "王嘉尔",
          "content": "我靠 NB了 ",
          "commentDate": "20:37",
          "praiseNum": "0",
          "replyNum": "0",
          "child": [],
          "videoId": "1295362901732765698",
          "commentId": "1296063705758314497",
          "isPraise": 0
        },
      ],
      "pageNum": 1,
      "pageSize": 10,
      "size": 2,
      "startRow": 1,
      "endRow": 2,
      "pages": 1,
      "prePage": 0,
      "nextPage": 0,
      "isFirstPage": true,
      "isLastPage": true,
      "hasPreviousPage": false,
      "hasNextPage": false,
      "navigatePages": 8,
      "navigatepageNums": [1],
      "navigateFirstPage": 1,
      "navigateLastPage": 1
    };

    RootShare shareData = RootShare.fromJson(data);
    CustomBottomSheet.showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(4),
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 20,
              alignment: Alignment.center,
              child: Text(
                '284164条评论',
                style: mediumTextStyle,
              ),
            ),
            ListViewWidget(dataList: shareData.list, callbackItem: _item),
            // _input()
          ],
        ),
      ),
    );
  }

  // 评论消息
  _item({item, bool isChild = false}) {
    bool loadMoreReplies = false;
    // 头像
    var leftImag = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(item.headImg,
            width: !isChild ? 40 : 30,
            height: !isChild ? 40 : 30,
            fit: BoxFit.cover),
      ),
    );
    // 名字和内容
    var info = StatefulBuilder(
        builder: (context, state) => GestureDetector(
              onTap: () {
                // state(() {
                //   backfillUserData = item;
                //   //  _checkedBottomSheet();
                //   _showModalBottomSheet();
                // });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.nickname,
                    style: skyGraySmallTextStyle,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: item.content, style: mediumTextStyle),
                      TextSpan(
                          text: '  ${item.commentDate}',
                          style: skyGraySmallTextStyle)
                    ]),
                  ),
                ],
              ),
            ));
    // 右侧心心
    var rightIcon = StatefulBuilder(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              state(() {
                if (token != null) {
                  shareLoveState = !shareLoveState;
                  if (shareLoveState) {
                    item?.isPraise++;
                  } else {
                    item?.isPraise--;
                  }
                } else {
                  ShowModelSheet.showLogin(context);
                }
              });
            },
            child: AnimatedSwitcherCounterRoute(
              showState: shareLoveState,
              child: _loveContainer(
                  !shareLoveState
                      ? 'assets/images/home/love_white/invalid_name.png'
                      : 'assets/images/home/love_active/invalid_name.png',
                  item?.isPraise,
                  true),
            ));
      },
    );
    // 子评论
    var itemChild = (item?.child != null &&
            item?.child?.length != 0 &&
            item.child != [])
        ? Column(
            children: <Widget>[
              ...item.child
                  .map((childItem) => _item(item: childItem, isChild: true)),
              StatefulBuilder(
                builder: (context, state) => GestureDetector(
                    onTap: () {
                      state(() {
                        loadMoreReplies = !loadMoreReplies;
                      });
                    },
                    child: _loading(loadMoreReplies)),
              )
            ],
          )
        : emptyWidget;
    // 集合评论
    var completeCommentItem = Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 解决图片基线中间对其的情况
      children: <Widget>[
        leftImag,
        Expanded(
          child: info,
        ),
        rightIcon
      ],
    );
    return Container(
        padding: EdgeInsets.only(
            left: !isChild ? 10 : 50, right: !isChild ? 10 : 0, top: 8),
        // EdgeInsets.symmetric(horizontal: !isChild ? 10 : 0, vertical: 6),
        child: Column(
          children: <Widget>[completeCommentItem, itemChild],
        ));
  }

  // 回复选项弹窗
  // _checkedBottomSheet() {
  //   return CupertinoActionSheet(

  //   );
  // }

  _input() {
    return TextField(
        controller: _controller,
        onChanged: (value) {},
        onTap: () {
          // var padding = MediaQuery.of(context).
        });
  }

  // 评论loading加载更多回复
  _loading(bool loading) {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 30,
      width: 200,
      child: !loading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '展开更多回复',
                  style: skyGraySmallTextStyle,
                ),
                Icon(Icons.arrow_drop_down, color: skyGray)
              ],
            )
          : LoadingWidget(
              loadingType: LoadingType.ballSpin,
              size: 16.0,
            ),
    );
  }

//  回复评论输入框
  _replyShare() {
    return TextField(
      scrollPadding: EdgeInsets.only(left: 20, right: 20),
      controller: _controller,
      onChanged: (value) {
        replyShareValue = value;
      },
      style: maxTextStyle,
      decoration: InputDecoration(
        hintText: "请输入",
        suffix: replyShareValue.length > 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.clear();
                  });
                },
                child: Icon(
                  Icons.clear,
                  size: 24,
                  color: Colors.white,
                ),
              )
            : emptyWidget,
      ),
    );
  }

  // 分享
  _shareBottomBox() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 160,
              child: Column(
                children: <Widget>[
                  Text('微信'),
                  Text('QQ'),
                ],
              ),
            ));
  }
}

// 爱心
Column _loveContainer(
        [String imageUrl, dynamic shareAndLoveNum, bool isShareLove = false]) =>
    Column(
      children: <Widget>[
        Image.asset(
          imageUrl,
          width: !isShareLove ? 40 : 30,
          height: !isShareLove ? 40 : 30,
        ),
        Text(
          shareAndLoveNum.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
        )
      ],
    );
