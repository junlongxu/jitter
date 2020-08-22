import 'dart:ui';
import 'package:jitter/model/share.dart';
import 'package:flutter/material.dart';
import 'package:jitter/pages/mypage/index.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'dart:convert';

import 'package:jitter/widgets/list_view_widget.dart';
import 'package:jitter/widgets/loading_widget.dart';

class ShareLoveMessage extends StatefulWidget {
  @override
  _ShareLoveMessageState createState() => _ShareLoveMessageState();
}

class _ShareLoveMessageState extends State<ShareLoveMessage> with Base {
  bool loveState = false;
  // bool shareState = false;
  String replyShareValue = ''; // 回复评论
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = '评论';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Row build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    loveState = !loveState;
                  });
                },
                child: AnimatedSwitcherCounterRoute(
                  showState: loveState,
                  child: _loveContainer(
                      !loveState
                          ? 'assets/images/love/invalid_name.png'
                          : 'assets/images/love_active/invalid_name.png',
                      '311.1w'),
                )),
            FloatingActionButton(
              onPressed: _showModalBottomSheet,
              elevation: 0.0,
              highlightElevation: 0.01,
              backgroundColor: Colors.transparent,
              child: _loveContainer('assets/images/information/invalid_name.png', '311.1w'),
            ),
            FloatingActionButton(
                onPressed: _shareBottomBox,
                elevation: 0.0,
                highlightElevation: 0.01,
                backgroundColor: Colors.transparent,
                child: _loveContainer('assets/images/share/invalid_name.png', '分享')),
          ],
        )
      ],
    );
  }

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
    // var data1 =json.decode(data.list);
    RootShare shareData = RootShare.fromJson(data);
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 500,
        padding: EdgeInsets.all(boundarySize),
        color: themeColor,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 4),
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 30,
              child: Text(
                '328464条评论',
                style: mediumTextStyle,
              ),
            ),
            // 评论
            ListViewWidget(dataList: shareData.list, callback: _eachComment),
            //  回复评论输入框
            _replyShare()
          ],
        ),
      ),
    );
  }

  // 父评论和子评论
  _eachComment({item, bool isChild = false}) {
    if (item == null) return null;
    bool shareLoveState = false;
    bool loadMoreReplies = false; // 加载更多
    
    return Container(
        constraints: BoxConstraints(minHeight: 80),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(!isChild ? 20 : 15),
            child: Image.network(
              item.headImg,
              width: !isChild ? 40 : 30,
              height: !isChild ? 40 : 30,
            ),
          ),
          // isThreeLine: true,
          // enabled: true,
          // isThreeLine: true,
          // dense: true,
          title: Text(
            item.nickname,
            style: skyGraySmallTextStyle,
          ),
          subtitle: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '起男人的注意么1? 呵呵呵 ${item.content} !',
                      style: mediumTextStyle),
                  TextSpan(
                      text: '  ${item.commentDate}',
                      style: skyGraySmallTextStyle)
                ]),
              ),
              // 子评论
              (item?.child != null &&
                      item?.child?.length != 0 &&
                      item.child != [])
                  ? Column(
                      children: <Widget>[
                        ...item.child.map((childItem) =>
                            _eachComment(item: childItem, isChild: true)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                loadMoreReplies = !loadMoreReplies;
                              });
                            },
                            child: !loadMoreReplies
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        '展开更多回复',
                                        style: skyGraySmallTextStyle,
                                      ),
                                      Icon(Icons.arrow_drop_down,
                                          color: skyGray)
                                    ],
                                  )
                                : LoadingWidget(
                                    loadingType: LoadingType.ballSpin,
                                    size: 15.0,
                                  ))
                      ],
                    )
                  : emptyWidget,
            ],
          ),
          trailing: Container(
            width: 30,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    shareLoveState = !shareLoveState;
                  });
                },
                child: AnimatedSwitcherCounterRoute(
                  showState: shareLoveState,
                  child: _loveContainer(
                      !shareLoveState
                          ? 'assets/images/love_white/invalid_name.png'
                          : 'assets/images/love_active/invalid_name.png',
                      '1.6w'),
                )),
          ),
          onTap: () {
            // _switchReply(item['name']);
          },
        ));
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
      // focusNode: ,
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
Container _loveContainer(
        [String imageUrl, String description, bool isHideText = false]) =>
    Container(
      // height: 50,
      child: Column(
        children: <Widget>[
          Image.asset(
            imageUrl,
            width: 36,
            height: 36,
          ),
          !isHideText
              ? Text(
                  description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                )
              : Text('')
        ],
      ),
    );
