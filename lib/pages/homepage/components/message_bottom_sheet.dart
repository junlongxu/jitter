import 'package:flutter/material.dart';
import 'package:jitter/model/share.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/list_view_widget.dart';

import 'package:jitter/dart/bottomSheet.dart' as CustomBottomSheet;

class EachComment extends StatelessWidget with Base {
  // @override
  Widget build(BuildContext context) {
    return emptyWidget;
  }

  TextEditingController _controller = TextEditingController();

  // 底部弹框
  Future showModalBottomSheet(BuildContext context) {
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
    RootShare shareData = RootShare.fromJson(data);
    // BottomsheetUtil.sheet(context: context, chi );
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
    // bool loadMoreReplies = false;
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
  }

  _input() {
    return TextField(
        controller: _controller,
        onChanged: (value) {},
        onTap: () {
          // var padding = MediaQuery.of(context).
        });
  }
}
