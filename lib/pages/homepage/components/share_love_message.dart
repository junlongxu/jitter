import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jitter/model/share.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'dart:convert';

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
              child: _loveContainer(
                  'assets/images/information.png', '311.1w'),
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
    List list = [1, 2, 3, 4, 5, 6, 7, 8];
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
                      '328464条评1论',
                      style: mediumTextStyle,
                    ),
                  ),
                  Expanded( // 待添加下拉刷新, 下拉加载
                    child: ListView.builder(
                        // controller: ,
                        itemCount: list?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EachComment(comment: list[index]);
                        }),
                  )
                ],
              ),
            ));
  }
}

class EachComment extends StatefulWidget {
  final int comment;
  const EachComment({@required this.comment});
  @override
  _EachCommentState createState() => _EachCommentState();
}

class _EachCommentState extends State<EachComment> with Base {
  bool shareLoveState = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      constraints: BoxConstraints(minHeight: 60),
      child: Wrap(
        textDirection: TextDirection.ltr,
        alignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            child: Image.network(
              'http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png',
              width: 40,
              height: 40,
            ),
          ),
          Expanded(
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 280,
                  padding: EdgeInsets.fromLTRB(6, 0, 10, 0),
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
                            text:
                                '穿这么短干嘛? 故意引起男人的注意么? 呵呵呵 !',
                            style: maxTextStyle),
                        TextSpan(text: '  6-13', style: TextStyle(color: skyGray))
                      ])),
                      EachComment()
                    ],
                  ),
                ),
              ],
            ),
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
    );
  }
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
