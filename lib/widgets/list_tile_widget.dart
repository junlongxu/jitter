import 'package:flutter/material.dart';
import 'package:jitter/util/NavigatorUtil.dart';

class ListTileWidget extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget page;

  const ListTileWidget(
      {this.leading, this.title, this.subtitle, this.trailing, this.page});

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushCuper(
          context,
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xff242a37),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // 重新渲染用户中心
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            body: page,
          ),
        );
      },
      child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing),
    );
  }
}
