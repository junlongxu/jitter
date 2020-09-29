import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/widgets/button_widget.dart';

class Share extends StatelessWidget {
  final VideosListItem item;
  const Share({this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.asset(
              'assets/images/home/share_background/invalid_name.png',
              height: 530,
            ),
            Image.network(item.headImage),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ButtonWidget(
            afterTitle: '复制成功, 赶快去分享吧!',
            height: 30,
            width: 250,
            showState: false,
            callback: () {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ButtonWidget(
              icon:
                  Image.asset('assets/images/home/share_copy/invalid_name.png'),
              title: '复制链接分享',
              callback: () {},
            ),
            ButtonWidget(
              icon:
                  Image.asset('assets/images/home/share_down/invalid_name.png'),
              title: '保存图片分享',
              callback: () {},
            ),
          ],
        )
      ],
    );
  }
}
