import 'package:flutter/material.dart';
import 'package:jitter/util/animation.dart';
import 'package:jitter/util/eventBus.dart';
import 'package:video_player/video_player.dart';
import 'package:jitter/widgets/loading_widget.dart';
import 'dart:ui' as ui;
import 'dart:async';

GlobalKey<_PlayerState> childPlayerKey = GlobalKey();

class Player extends StatefulWidget {
  final bool isClean;
  final String videoIdcUrl;
  final String videoImg;
  const Player({this.isClean = false, this.videoIdcUrl, this.videoImg});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  bool isPause = false;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget?.videoIdcUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
          // 传值
          if (!widget.isClean) {
            eventBus.fire(new VideoPlayerEvent(controller: _controller));
          }
        });
      }).catchError((err) {
        print('Player页面$err');
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (!widget.isClean) {
      // int index = VideoPlayerEvent.controllers.indexOf(_controller);
      VideoPlayerEvent.controllers.remove(_controller);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(widget.videoImg);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      completer.complete(image.image);
    }));
    return new FutureBuilder<ui.Image>(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          return _player(snapshot.data.width + .0, snapshot.data.height + .0);
          // return new Text(
          //   '${snapshot.data.width}x${snapshot.data.height}',
          //   style: Theme.of(context).textTheme.display3,
          // );
        } else {
          return new Text('');
        }
      },
    );
  }

  Widget _player(double width, double height) {
    double playerHeight;
    if (height > MediaQuery.of(context).size.height ||
        height > MediaQuery.of(context).size.height * 0.9) {
      playerHeight = double.infinity;
    } else {
      playerHeight = height * 0.8;
    }
    if (widget.isClean) {
      return Container(
        width: double.infinity,
        height: playerHeight,
        child: _controller.value.initialized
            ? VideoPlayer(_controller)
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget?.videoImg), fit: BoxFit.fill),
                ),
              ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (_controller.value.initialized) {
            playStop();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0),
          alignment: Alignment.center,
          child: PhysicalModel(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: width / height,
              child: _controller.value.initialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ScaleAnimationRoute(
                          child: GestureDetector(
                            onTap: () {
                              playStop();
                            },
                            child: AnimatedOpacity(
                              opacity: isPause ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 300),
                              child: Image.asset(
                                'assets/images/home/play/invalid_name.png',
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget?.videoImg),
                              fit: BoxFit.fill)),
                      // child: LoadingWidget(
                      //   loadingType: LoadingType.ballSpin,
                      //   size: 30.0,
                      // ),
                    ),
            ),
          ),
        ),
      );
    }
  }

  void playStop() {
    setState(() {
      isPause = !isPause;
    });
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }
}
