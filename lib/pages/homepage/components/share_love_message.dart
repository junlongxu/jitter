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
                  child: _container(
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
              child: _container('assets/images/information.png', '311.1w'),
            ),
            FloatingActionButton(
                // onPressed: launch('weixin://'),
                elevation: 0.0,
                highlightElevation: 0.01,
                backgroundColor: Colors.transparent,
                child: _container('assets/images/share.png', '分享')),
          ],
        )
      ],
    );
  }

  Container _container(String imageUrl, String description) => Container(
        height: 60,
        child: Column(
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: 36,
              height: 36,
            ),
            Text(
              description,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      );

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
          "nickname": "罗伟泽964",
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
              "nickname": "罗伟泽964",
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
          "nickname": "罗伟泽964",
          "content": "",
          "commentDate": "20:37",
          "praiseNum": "0",
          "replyNum": "0",
          "child": [],
          "videoId": "1295362901732765698",
          "commentId": "1296063705758314497",
          "isPraise": 0
        }
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
    // Utf8Decoder utf8decoder = Utf8Decoder();
    // List<Map<String, dynamic>> res = json.decode("{""}");
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 500,
              padding: EdgeInsets.all(boundarySize),
              color: themeColor,
              child: Column(
                children: <Widget>[
                  Text(
                    '328464条评论',
                    style: mediumTextStyle,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: shareData?.list?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _eachComment(shareData?.list[index]);
                        }),
                  )
                ],
              ),
            ));
  }

  _eachComment(comment) {
    if (comment == null) return null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Image.network(comment.headImg)
        CircleAvatar(
          child: Image.network(comment.headImg),
        ),
        Text(
          'data',
          style: mediumTextStyle,
        ),
        Text(
          'data',
          style: mediumTextStyle,
        )
      ],
    );
  }
}
