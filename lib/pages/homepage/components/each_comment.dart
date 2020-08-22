import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

import 'package:jitter/widgets/loading_widget.dart';

class EachComment extends StatelessWidget with Base {
  final item;
  final bool isChild;
  EachComment({Key key, this.item, this.isChild}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool shareLoveState = false;
    bool loadMoreReplies = false;
    return Container(
        constraints: BoxConstraints(minHeight: 80),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(!isChild ? 20 : 15),
            child: Image.network(
              item.headImg,
              width: !isChild ? 40 : 30,
              height: !isChild ? 40 : 30,
            ),
          ),
          title: Text(
            item.nickname,
            style: skyGraySmallTextStyle,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '起男人的注意么1? 呵呵呵 ${item.content} !',
                      style: mediumTextStyle),
                  TextSpan(
                      text: '  ${item.commentDate}',
                      style: skyGraySmallTextStyle)
                ]),
              ),
              // 子评论
              // (item?.child != null &&
              //         item?.child?.length != 0 &&
              //         item.child != [])
              //     ? Column(
              //         children: <Widget>[
              //           ...item.child.map((childItem) =>
              //               EachComment(item: childItem, isChild: true)),
              //           GestureDetector(
              //               onTap: () {
              //                 // setState(() {
              //                 //   loadMoreReplies = !loadMoreReplies;
              //                 // });
              //               },
              //               child: !loadMoreReplies
              //                   ? Row(
              //                       children: <Widget>[
              //                         Text(
              //                           '展开更多回复',
              //                           style: skyGraySmallTextStyle,
              //                         ),
              //                         Icon(Icons.arrow_drop_down,
              //                             color: skyGray)
              //                       ],
              //                     )
              //                   : LoadingWidget(
              //                       loadingType: LoadingType.ballSpin,
              //                       size: 15.0,
              //                     ))
              //         ],
              //       )
              //     : emptyWidget,
            ],
          ),
          // trailing: Container(
          //   width: 30,
          //   child: GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           shareLoveState = !shareLoveState;
          //         });
          //       },
          //       child: AnimatedSwitcherCounterRoute(
          //         showState: shareLoveState,
          //         child: _loveContainer(
          //             !shareLoveState
          //                 ? 'assets/images/love_white/invalid_name.png'
          //                 : 'assets/images/love_active/invalid_name.png',
          //             '1.6w'),
          //       )),
          // ),
          onTap: () {
            // _switchReply(item['name']);
          },
        ));
  }
}
