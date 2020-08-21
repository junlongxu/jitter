import 'dart:ui';
import 'package:jitter/model/share.dart';
import 'package:flutter/material.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'dart:convert';

import 'package:jitter/widgets/list_view_widget.dart';

class ShareLoveMessage extends StatefulWidget {
  @override
  _ShareLoveMessageState createState() => _ShareLoveMessageState();
}

class _ShareLoveMessageState extends State<ShareLoveMessage> with Base {
  bool loveState = false;
  bool shareState = false;
  @override
  Row build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
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
                          ? 'assets/images/love.png'
                          : 'assets/images/love_active.png',
                      '311.1w'),
                )),
            FloatingActionButton(
              onPressed: _showModalBottomSheet,
              elevation: 0.0,
              highlightElevation: 0.01,
              backgroundColor: Colors.transparent,
              child: _loveContainer('assets/images/information.png', '311.1w'),
            ),
            FloatingActionButton(
                // onPressed: launch('weixin://'),
                elevation: 0.0,
                highlightElevation: 0.01,
                backgroundColor: Colors.transparent,
                child: _loveContainer('assets/images/share.png', '分享')),
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
            // {
            //   "id": "1296065550417408002",
            //   "parentId": "0",
            //   "headImg":
            //       "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
            //   "userId": "1296063479924404226",
            //   "nickname": "孩子",
            //   "content": "2",
            //   "commentDate": "20:44",
            //   "praiseNum": "0",
            //   "toReplyUserId": "1296063479924404226",
            //   "toReplyUserImg":
            //       "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png",
            //   "toReplyUserName": "罗伟泽964",
            //   "commentId": "1296065391553949698",
            //   "isPraise": 0
            // },
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
                    height: 30,
                    child: Text(
                      '328464条评论',
                      style: mediumTextStyle,
                    ),
                  ),
                  ListViewWidget(
                      dataList: shareData.list, callback: _eachComment),
                  Text(
                    '暂无更多',
                    style: smallTextStyle,
                  )
                ],
              ),
            ));
  }

  _eachComment({item, width}) {
    if (item == null) return null;
    bool shareLoveState = false;
    bool isArrow = false;
    return Column(
      children: <Widget>[
        Wrap(
          textDirection: TextDirection.ltr,
          alignment: WrapAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
                child: Image.network(
              item.headImg,
              width: 40,
              height: 40,
            )),
            Expanded(
              child: Wrap(
                children: <Widget>[
                  Container(
                    width: width ?? 290,
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '木头',
                          style: TextStyle(color: skyGray),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '穿这么短干嘛? 故意引起男人的注意么? 呵呵呵 ${item.content} !',
                              style: maxTextStyle),
                          TextSpan(
                              text: '  ${item.commentDate}',
                              style: TextStyle(color: skyGray))
                        ])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20, // 防止child为空的时候评论错乱
              margin: EdgeInsets.only(top: 22, right: 6),
              // 右侧箭头
              // child: (comment != null)
              //     ? GestureDetector(
              //       onTap: (){
              //         setState(() {
              //           isArrow = !isArrow;
              //         });
              //       },
              //       child: Icon(
              //         isArrow ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              //         color: skyGray,
              //       ),
              //     )
              //     : Text(' '),
            ),
            Container(
              width: 30,
              padding: EdgeInsets.only(top: 4),
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
                            ? 'assets/images/love_white.png'
                            : 'assets/images/love_active.png',
                        '1.6w'),
                  )),
            )
          ],
        ),
        (item?.child != null && item?.child?.length != 0 && item.child != [])
            ? Container(
                height: 50,
                margin: EdgeInsets.only(left: 50),
                child: _eachComment(item: item.child[0]),
              )
            : Text(
                ' 222 ',
                style: smallTextStyle,
              ),
      ],
    );
  }

  // 回复的评论
  // _dataiamge(comment) {
  //   // return ListViewWidget(dataList: comment?.child, callback: _eachComment, );
  //   return comment.child
  //       .map((item) => Container(child: _eachComment(item, 200.0)))
  //       .toList();
  // }
}

Container _loveContainer(
        [String imageUrl, String description, bool isHideText = false]) =>
    Container(
      height: 60,
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

// class AnimateGestureDetector{
//   bool loveState;
//   final Widget child;

//   AnimateGestureDetector({this.loveState, @required this.child});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     loveState = !loveState;
//                   });
//                 },
//                 child: AnimatedSwitcherCounterRoute(
//                   showState: loveState,
//                   child: _container(
//                       !loveState
//                           ? 'assets/images/love.png'
//                           : 'assets/images/love_active.png',
//                       '311.1w'),
//                 )),;
//   }
// }
