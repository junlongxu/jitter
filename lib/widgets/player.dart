import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:getflutter/getflutter.dart';

class Player extends StatefulWidget {
  final String url;
  const Player({this.url});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _controller;
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
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: 0.66,
                child: VideoPlayer(_controller),
              ))
          : Text('loading'),
    );
  }
}
