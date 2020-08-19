import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset("assets/images/share.png"),
      builder: (BuildContext ctx, Widget child) {
        return new Center(
          child: Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  final bool showState;
  final Widget child;
  final Alignment alignment;
  const AnimatedSwitcherCounterRoute(
      {Key key,
      @required this.showState,
      this.alignment = Alignment.center,
      @required this.child})
      : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  // bool _count = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              return ScaleTransition(
                  child: child,
                  scale: animation,
                  alignment: widget?.alignment);
            },
            child: Container(
              child: widget?.child,
              key: ValueKey<bool>(widget?.showState),
            ),
            // child: Text(
            //   '1',
            //   //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
            //   key: ValueKey<bool>(_count),
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ),
          // RaisedButton(
          //   child: const Text(
          //     '+1',
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       _count = !_count;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
