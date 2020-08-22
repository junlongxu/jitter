import 'package:flutter/material.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';

class CommentAvatar extends StatefulWidget {
  final String url;
  const CommentAvatar({Key key, this.url}) : super(key: key);
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
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  widget?.url,
                  width: 36,
                  height: 36,
                )),
            Container(
              
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                '@色情网1111',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xfffafafa), fontSize: 14),
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
                        width: loveState ? 36 : 18,
                        height: 18,
                        // padding: EdgeInsets.only(top: 10),
                        child: loveState
                            ? Text(
                                '关注',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
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
              child: Text('这位小姐姐太厉害了, 我完全不是她的对手耶 !',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}
