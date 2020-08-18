import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

class Player extends StatefulWidget {
  final String url;
  const Player({@required this.url});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _controller;
  bool isPause = false;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget?.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      }).catchError((err) {
        print('Player页面$err');
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: _controller.value.initialized
          ? GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  isPause = true;
                  _controller.pause();
                } else {
                  isPause = false;
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: 0.66,
                child: VideoPlayer(_controller),
              ),
              // child: Center(
              //   child: Stack(
              //     children: <Widget>[
              //       AspectRatio(
              //         aspectRatio: 0.66,
              //         child: VideoPlayer(_controller),
              //       ),
              //       isPause
              //           ? Positioned(
              //               top: MediaQuery.of(context).size.height * 0.4,
              //               left: MediaQuery.of(context).size.width * 0.4,
              //               child: Text('11111'))
              //           : Positioned(
              //               top: MediaQuery.of(context).size.height * 0.4,
              //               left: MediaQuery.of(context).size.width * 0.4,
              //               child: Image.asset(
              //                 'assets/images/pause.png',
              //                 width: 80,
              //                 height: 80,
              //               ))
              //     ],
              //   ),
              // )
            //   left: 0,
            // right: 0,
            // bottom: 0,
            // top: 54,
 
            )
          : Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0),
    );
  }
}
