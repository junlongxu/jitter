import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

enum LoadingType { ballSpin }

class LoadingWidget extends StatefulWidget {
  final double size;
  final LoadingType loadingType;
  const LoadingWidget({Key key, this.size, this.loadingType}) : super(key: key);
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.lightBlue,
      child: Center(
        child: Loading(
            indicator: BallSpinFadeLoaderIndicator(), size: widget?.size),
      ),
    );
  }
}


