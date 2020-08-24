import 'dart:ui';
import 'package:jitter/model/share.dart';
import 'package:flutter/material.dart';
import 'package:jitter/pages/homepage/components/bottom.dart';
import 'package:jitter/pages/mypage/index.dart';
import 'package:jitter/util/BottomsheetUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'dart:convert';
import 'package:jitter/widgets/loading_widget.dart';

import 'package:jitter/widgets/list_view_widget.dart';
import 'package:jitter/dart/bottomSheet.dart' as CustomBottomSheet;


class ShareLoveMessage extends StatefulWidget {
  @override
  _ShareLoveMessageState createState() => _ShareLoveMessageState();
}

class _ShareLoveMessageState extends State<ShareLoveMessage> with Base {
  bool loveState = false;
  bool shareLoveState = false;
  String inputValue = '';
  var backfillUserData;
  // bool shareState = false;
  String replyShareValue = ''; // 回复评论
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
  Column build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _itemRightIconHeight(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  loveState = !loveState;
                });
              },
              child: AnimatedSwitcherCounterRoute(
                showState: loveState,
                child: _loveContainer(
                    !loveState
                        ? 'assets/images/home/love/invalid_name.png'
                        : 'assets/images/home/love_active/invalid_name.png',
                    '311.1w'),
              )),
        ),
        _itemRightIconHeight(
          child: FloatingActionButton(
            onPressed: _showModalBottomSheet,
            elevation: 0.0,
            highlightElevation: 0.01,
            backgroundColor: Colors.transparent,
            child: _loveContainer(
                'assets/images/home/information/invalid_name.png', '311.1w'),
          ),
        ),
        _itemRightIconHeight(
          child: FloatingActionButton(
              onPressed: _shareBottomBox,
              elevation: 0.0,
              highlightElevation: 0.01,
              backgroundColor: Colors.transparent,
              child:
                  _loveContainer('assets/images/home/share/invalid_name.png', '分享')),
        )
      ],
    );
  }

  // 右侧每个icon设置高度
  _itemRightIconHeight({Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: child,
    );
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
              "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
          "userId": "1296063479924404226",
          "nickname": "父亲",
          "content": "1",
          "commentDate": "20:44",
          "praiseNum": "0",
          "replyNum": "1",
          "child": [
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "userId": "1296063479924404226",
              "nickname": "孩子",
              "content": "2",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "toReplyUserName": "罗伟泽964",
              "commentId": "1296065391553949698",
              "isPraise": 0
            },
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "userId": "1296063479924404226",
              "nickname": "孩子2",
              "content": "2",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "toReplyUserName": "罗伟泽964",
              "commentId": "1296065391553949698",
              "isPraise": 0
            },
            {
              "id": "1296065550417408002",
              "parentId": "0",
              "headImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "userId": "1296063479924404226",
              "nickname": "孩子3",
              "content": "2",
              "commentDate": "20:44",
              "praiseNum": "0",
              "toReplyUserId": "1296063479924404226",
              "toReplyUserImg":
                  "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
              "toReplyUserName": "罗伟泽964",
              "commentId": "1296065391553949698",
              "isPraise": 0
            }
          ],
          "videoId": "1295362901732765698",
          "commentId": "1296065391553949698",
          "isPraise": 0
        },
        {
          "id": "1296063705758314497",
          "parentId": "0",
          "headImg":
              "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
          "userId": "1296063479924404226",
          "nickname": "母亲",
          "content": "22",
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
    Utf8Decoder utf8decoder = Utf8Decoder();
    RootShare shareData = RootShare.fromJson(data);
    CustomBottomSheet.showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
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
                      '328464条评论',
                      style: mediumTextStyle,
                    ),
                  ),
                  ListViewWidget(dataList: shareData.list, callback: _item),
                  _input()
                ],
              ),
            ));
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
                state(() {
                  backfillUserData = item;
                  //  _checkedBottomSheet();
                  _showModalBottomSheet();
                });
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
                      TextSpan(
                          text:
                              '起男人的多阿萨达算哒算123阿斯萨达萨达撒阿斯顿撒电费第三方sadasa哒呵呵 ${item.content} !',
                          style: mediumTextStyle),
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
            onTap: () {
              state(() {
                shareLoveState = !shareLoveState;
               
              });
            },
            child: AnimatedSwitcherCounterRoute(
              showState: shareLoveState,
              child: _loveContainer(
                  !shareLoveState
                      ? 'assets/images/home/love_white/invalid_name.png'
                      : 'assets/images/home/love_active/invalid_name.png',
                  '59'),
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
Container _loveContainer([String imageUrl, String description]) => Container(
      height: 50,
      child: Column(
        children: <Widget>[
          Image.asset(
            imageUrl,
            width: 30,
            height: 30,
          ),
          Text(
            description,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
