import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'dart:async';

class ButtonWidget extends StatefulWidget {
  final Function callback;
  final String title;
  final String afterTitle;
  final double circularSize;
  final double height;
  final double width;
  final bool isShowColor;
  final bool showState;
  final Widget icon;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BuildContext toastPopContext;
  const ButtonWidget(
      {Key key,
      this.callback,
      this.circularSize = 25,
      this.height = 30,
      this.width,
      this.margin,
      this.padding,
      this.isShowColor = true,
      this.toastPopContext,
      this.title,
      this.afterTitle,
      this.showState = true,
      this.icon})
      : super(key: key);
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> with Base {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _container;
  }

  Container get _container => Container(
        height: widget?.height,
        width: widget?.width,
        padding: widget?.padding,
        margin: widget?.margin,
        alignment: Alignment.center,
        decoration: widget.showState
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xfff54b64), Color(0xfff78361)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
                borderRadius: BorderRadius.circular(widget?.circularSize),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0000), Color(0xff0000)],
                ),
                border: Border.all(width: 1, color: Color(0xff4b5774)),
                borderRadius: BorderRadius.circular(widget?.circularSize),
              ),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget?.circularSize),
            ),
            color: Colors.transparent, // 设为透明色
            elevation: 0, // 正常时阴影隐藏
            highlightElevation: 0, // 点击时阴影隐藏
            onPressed: () async{
              if (widget?.callback != null) {
                widget?.callback();
                // if (widget.isShowToast) {
                //   Toast111.show(widget.toastPopContext);
                //   const timeout = const Duration(milliseconds: 200);
                //   Timer(timeout, () {
                //     Toast111.hide(widget.toastPopContext);
                //   });
                // }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget?.icon != null
                    ? Container(
                        width: 25,
                        height: 25,
                        padding: EdgeInsets.only(right: 4),
                        child: widget?.icon,
                      )
                    : emptyWidget,
                Container(
                  // alignment: Alignment.center,
                  height: widget?.height,
                  alignment: Alignment.center,
                  child: Text(
                    widget.showState ? widget?.title : widget?.afterTitle,
                    style: largeTextStyle,
                  ),
                ),
              ],
            )),
      );
}

class Toast111 {
  static void show(BuildContext context, {bool mateStyle}) {
    Navigator.of(context).push(DialogRouter(ToastDialog()));
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop(true);
  }
}

class DialogRouter extends PageRouteBuilder {
  final Widget page;

  DialogRouter(this.page)
      : super(
          opaque: false,
          barrierColor: Color(0x00000001),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}

class ToastDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          //创建透明层
          type: MaterialType.transparency, //透明类型
          child: Center(
              //保证控件居中效果
              // child: CupertinoActivityIndicator(
              //   radius: 50,
              // ),
              child: Opacity(
            opacity: 0.9,
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xff20242f),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                '成 功',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
        ),
        onWillPop: () async {
          return Future.value(false);
        });
  }
}
