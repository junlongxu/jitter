import 'package:flutter/material.dart';
import 'components/skip_down_time.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return new Stack(
        // alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset(
            'assets/images/startPage/startPage.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          new Container(
            child: Align(
              alignment: Alignment.topRight,
              child: new Container(
                padding: EdgeInsets.only(top: 50.0, right: 20.0),
                child: new SkipDownTimeProgress(
                  Colors.red,
                  22.0,
                  new Duration(seconds: 4),
                  new Size(25.0, 25.0),
                  skipText: "跳过",
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
