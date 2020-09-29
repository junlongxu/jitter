import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'components/comment_avatar.dart';
import 'components/share_love_message.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/player.dart';

class PlayerItem extends StatefulWidget {
  final VideosListItem item;
  // 视频列表
  const PlayerItem({Key key, this.item}) : super(key: key);
  @override
  _PlayerItemState createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> with Base {
  int truePageNum = 1;
  List<VideosListItem> list = new List();
  Map<String, Function> methods = new Map();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: themeColor,
        child: ShareInherited(
          methods: methods,
          child: Stack(
            children: <Widget>[
              Player(
                  videoIdcUrl: widget.item.videoIdcUrl,
                  videoImg: widget.item.videoImg),
              CommentAvatar(item: widget?.item),
              ShareLoveMessage(item: widget?.item)
            ],
          ),
        ));
  }
}

class ShareInherited extends InheritedWidget {
  final Map<String, Function> methods;
  ShareInherited({this.methods, @required Widget child}) : super(child: child) {
    print('1');
  }

  @override
  bool updateShouldNotify(ShareInherited oldWidget) {
    bool result = oldWidget.methods != this.methods;
    print('ShareInherited updateShouldNotify result = $result');
    return result;
  }

  static ShareInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
