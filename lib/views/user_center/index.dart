import 'package:flutter/material.dart';
import 'package:jitter/api/home.dart';
import 'package:jitter/model/user_info.dart';
import 'package:jitter/store/index.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/loading_widget.dart';

import 'components/foolow_fans_like.dart';
import 'components/user_top_msg.dart';
import 'components/works_likes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserCenter extends StatefulWidget {
  final String userId;
  final Widget topChild;
  final Widget centerChild;
  final bool isSelf;
  Function callbackBtnStateFn;
  UserCenter({
    this.userId,
    this.topChild,
    this.centerChild,
    this.isSelf = false,
    this.callbackBtnStateFn,
  });
  @override
  _UserCenterState createState() => _UserCenterState();
}

// getUserInfo
class _UserCenterState extends State<UserCenter>
    with Base, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: themeColor,
    //   padding: EdgeInsets.fromLTRB(boundarySize, 0, boundarySize, 0),
    //   child: FutureBuilder<UserInfo>(
    //       future: _getUserInfo(),
    //       // ignore: missing_return
    //       builder: (BuildContext context, AsyncSnapshot<UserInfo> snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //             child: LoadingWidget(
    //               loadingType: LoadingType.ballSpin,
    //               size: 30.0,
    //             ),
    //           );
    //         } else if (snapshot.data != null) {
    //           UserInfo userInfo = snapshot.data;
    //           return ChangeNotifierProvider.value(
    //             value: userInfo,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 widget.isSelf ? widget.topChild : emptyWidget,
    //                 UserTopMsg(
    //                   userInfo: userInfo,
    //                   callbackUserInfo: _getUserInfo,
    //                   callbackBtnStateFn: widget.callbackBtnStateFn,
    //                 ),
    //                 FoolowFansLike(
    //                     userInfo: userInfo, callbackUserInfo: _getUserInfo),
    //                 widget.isSelf ? widget.centerChild : emptyWidget,
    //                 WorksLikes(
    //                     userInfo: userInfo, callbackUserInfo: _getUserInfo)
    //               ],
    //             ),
    //           );
    //         }
    //       }),
    // );
    return Container(
      color: themeColor,
      padding: EdgeInsets.fromLTRB(boundarySize, 0, boundarySize, 0),
      child: FutureBuilder<UserInfo>(
          future: _getUserInfo(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<UserInfo> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingWidget(
                  loadingType: LoadingType.ballSpin,
                  size: 30.0,
                ),
              );
            } else if (snapshot.data != null) {
              UserInfo userInfo = snapshot.data;
              return ChangeNotifierProvider.value(
                value: CounterNotifier(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.isSelf ? widget.topChild : emptyWidget,
                    UserTopMsg(
                      userInfo: userInfo,
                      callbackUserInfo: _getUserInfo,
                      callbackBtnStateFn: widget.callbackBtnStateFn,
                    ),
                    FoolowFansLike(
                        userInfo: userInfo, callbackUserInfo: _getUserInfo),
                    widget.isSelf ? widget.centerChild : emptyWidget,
                    WorksLikes(
                        userInfo: userInfo, callbackUserInfo: _getUserInfo)
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<UserInfo> _getUserInfo() async {
    UserInfo userInfoData = await getUserInfo(userId: widget?.userId);
    return userInfoData;
  }
}

