import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/pages/login/components/show_model_sheet.dart';
import 'package:video_player/video_player.dart';

import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/eventBus.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/views/user_center/index.dart';

class CommentAvatar extends StatefulWidget {
  final VideosListItem item;
  const CommentAvatar({Key key, this.item}) : super(key: key);
  _CommentAvatarState createState() => _CommentAvatarState();
}

class _CommentAvatarState extends State<CommentAvatar> with Base {
  bool loveState = false;

  @override
  void initState() {
    // eventBus
    //     .on<VideoPlayerEvent>()
    //     .listen((VideoPlayerEvent data) => setState(() {
    //           controllers = data.controllers;
    //         }));

    super.initState();
  }

  @override
  Padding build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      try {
                        List<VideoPlayerController> controllers =
                            VideoPlayerEvent.controllers;
                        VideoPlayerController controller = controllers[controllers.length - 1];
                        Function play = () => controller.play();
                        Function pause = () => controller.pause();
                        pause();
                        if (SpUtil.prefs.getString('token') != null) {
                          NavigatorUtil.pushCuper(
                            context,
                            Scaffold(
                              appBar: AppBar(
                                elevation: 0,
                                backgroundColor: themeColor,
                                leading: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    play();
                                  },
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                              body: UserCenter(userId: widget.item.authorId),
                            ),
                          );
                        } else {
                          ShowModelSheet.showLogin(context).then((void res) {
                            return play();
                          });
                        }
                      } catch (err) {
                        print(err);
                      }
                    },
                    child: ClipOval(
                      child: SizedBox(
                        child: Image.network(
                          widget?.item?.headImage,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      widget?.item?.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: maxTextStyle,
                    ),
                  ),
                  Container(
                      // padding: EdgeInsets.only(bottom: 4),
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            if (SpUtil.prefs.getString('token') != null) {
                              setState(() {
                                loveState = !loveState;
                              });
                            } else {
                              ShowModelSheet.showLogin(context);
                            }
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          '关注',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
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
                        style: maxTextStyle),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
