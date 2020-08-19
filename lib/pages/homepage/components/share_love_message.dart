// import 'package:flutter/cupertino.dart';
// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:jitter/util/animation.dart';

class ShareLoveMessage extends StatefulWidget {
  @override
  _ShareLoveMessageState createState() => _ShareLoveMessageState();
}

class _ShareLoveMessageState extends State<ShareLoveMessage> {
  bool loveState = false;
  @override
  Row build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    loveState = !loveState;
                  });
                },
                child: AnimatedSwitcherCounterRoute(
                  showState: loveState,
                  child: _container(
                      !loveState
                          ? 'assets/images/love.png'
                          : 'assets/images/love_active.png',
                      '311.1w'),
                )),
            _container('assets/images/information.png', '311.1w'),
            _container('assets/images/share.png', '分享'),
            Stack(
              children: <Widget>[
                // ScaleAnimationRoute(),
                AnimatedSwitcherCounterRoute()
              ],
            ),
          ],
        )
      ],
    );
  }

  Container _container(String imageUrl, String description) => Container(
        height: 60,
        child: Column(
          children: <Widget>[
            Image.asset(imageUrl),
            Text(
              description,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      );
}
