import 'package:flutter/material.dart';
import 'package:jitter/api/home.dart';
import 'package:jitter/model/user_info.dart';
import 'package:jitter/store/index.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/button_widget.dart';
import 'package:jitter/widgets/photo_view_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserTopMsg extends StatefulWidget {
  UserInfo userInfo;
  final Function callbackUserInfo;
  Function callbackBtnStateFn;

  UserTopMsg({this.userInfo, this.callbackUserInfo, this.callbackBtnStateFn});
  @override
  _UserTopMsgState createState() => _UserTopMsgState();
}

class _UserTopMsgState extends State<UserTopMsg> with Base {
  bool isFollow = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterNotifier>(context);
    counter.increment();
    print('----------${counter.userInfo}');
    return _userMsg;
  }

  Widget get _userMsg {
    // 如果不是自己
    if (!widget.userInfo.areSelf) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  NavigatorUtil.pushScale(
                    context,
                    PhotoViewSimpleScreen(
                      imageProvider: NetworkImage(widget?.userInfo?.headImage),
                      heroTag: 'simple',
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(widget?.userInfo?.headImage,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AnimatedSwitcherCounterRoute(
                      showState: widget.userInfo.attention,
                      child: ButtonWidget(
                        title: '关 注',
                        afterTitle: '已 关 注',
                        showState: !widget.userInfo.attention,
                        toastPopContext: context,
                        width: 200,
                        callback: () {
                          if (!widget.userInfo.attention) {
                            addFollowUsers(userId: widget.userInfo.userId).then(
                              (res) {
                                setState(() {
                                  widget.userInfo.attention =
                                      !widget.userInfo.attention;
                                  widget.callbackBtnStateFn(
                                      widget.userInfo.attention);
                                });
                                showToast('关 注 成 功');
                              },
                            ).catchError((err) {});
                          } else {
                            delFollowUsers(userId: widget.userInfo.userId).then(
                              (res) {
                                setState(() {
                                  widget.userInfo.attention =
                                      !widget.userInfo.attention;
                                  widget.callbackBtnStateFn(
                                      widget.userInfo.attention);
                                });
                                showToast('取 消 关 注');
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _textBackground('${widget?.userInfo?.age}岁', true, 2),
                          _textBackground(widget?.userInfo?.area ?? '朝阳区'),
                          _textBackground(
                              widget?.userInfo?.constellation ?? '白羊座'),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
            widget?.userInfo?.nickName,
            style: largeTextStyle,
          ),
          Text(
            widget.userInfo.remark.length == 0
                ? '个性签名: 做更加好的自己'
                : widget?.userInfo?.remark,
            style: skyGraySmallTextStyle,
          )
        ],
      );
    } else {
      // 当前用户的个人中心
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              NavigatorUtil.pushScale(
                context,
                PhotoViewSimpleScreen(
                  imageProvider: NetworkImage(widget?.userInfo?.headImage),
                  heroTag: 'simple',
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget?.userInfo?.headImage,
                    width: 60, height: 60, fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget?.userInfo?.nickName,
                  style: largeTextStyle,
                ),
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _textBackground('${widget?.userInfo?.age}岁', true, 2),
                      _textBackground(widget?.userInfo?.area ?? '朝阳区'),
                      _textBackground(widget?.userInfo?.constellation ?? '白羊座'),
                    ],
                  ),
                ),
                Text(
                  widget.userInfo.remark.length == 0
                      ? '个性签名: 做更加好的自己'
                      : widget?.userInfo?.remark,
                  style: skyGraySmallTextStyle,
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _textBackground([String title, bool showIcon = false, int sex = 1]) {
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 20,

      // padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          // color: Colors.black,
          border: Border.all(width: 0.5, color: Color(0xff4b5774)),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showIcon
              ? Icon(
                  sex == 1 ? Icons.maximize : Icons.memory,
                  size: 12,
                )
              : emptyWidget,
          Container(
              width: 45,
              alignment: Alignment.center,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: smallTextStyle,
              ))
        ],
      ),
    );
  }
}
