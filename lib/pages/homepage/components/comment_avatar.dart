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
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1)),
              child: CircleAvatar(
                child: Image.network(widget?.url),
              ),
            ),
            Container(
              width: 90.0,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 6),
              child: Text(
                '@色情网',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xfffafafa), fontSize: 18),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 4),
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
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}
