import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/pages/taskpage/index.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';

class CommentAvatar extends StatefulWidget {
  final VideosListItem item;
  const CommentAvatar({Key key, this.item}) : super(key: key);
  _CommentAvatarState createState() => _CommentAvatarState();
}

class _CommentAvatarState extends State<CommentAvatar> with Base {
  bool loveState = false;
  @override
  Column build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                NavigatorUtil.push(context, TaskPage());
              },
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.network(
                    widget?.item?.headImage,
                    width: 50,
                    height: 50,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                widget?.item?.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xfffafafa), fontSize: 16),
              ),
            ),
            Container(
                // padding: EdgeInsets.only(bottom: 4),
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        loveState = !loveState;
                      });
                    },
                    child: AnimatedSwitcherCounterRoute(
                      showState: loveState,
                      alignment: Alignment.centerLeft,
                      child: containerGradient(
                        width: loveState ? 50 : 25,
                        height: 25,
                        // padding: EdgeInsets.only(top: 10),
                        child: loveState
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text(
                                    '关注',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              )
                            : Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 14,
                              ),
                      ),
                    ))),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 200,
              margin: EdgeInsets.only(left: 8, top: 8),
              child: Text(widget?.item?.videoTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}
