import 'package:flutter/material.dart';
import 'package:jitter/api/login.dart';
import 'package:jitter/model/login.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/widgets/button_widget.dart';
import 'package:jitter/widgets/player.dart';

class LoginPage extends StatefulWidget {
  // int currentIndex;
  // int index;
  // LoginPage({Key key, this.currentIndex, this.index}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Base {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      // padding: EdgeInsets.all(boundarySize),
      child: Stack(
        children: <Widget>[
          Player(
            videoIdcUrl:
                'http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020090719/1290895585221619714/mp4/安卓登录背景视频.mp4',
            videoImg: 'assets/images/login/background/invalid_name.jpg',
            isClean: true,
          ),
          Column(
            children: <Widget>[
              Image.asset(
                'assets/images/login/logo/invalid_name.png',
                width: 180,
                height: 180,
              ),
              _loginForm()
            ],
          ),
        ],
      ),
    );

    // return Container(
    //   width: size.width,
    //   height: size.height,
    //   padding: EdgeInsets.all(boundarySize),
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image:
    //             AssetImage('assets/images/login/background/invalid_name.jpg'),
    //         fit: BoxFit.cover),
    //   ),
    //   child: new SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         Image.asset(
    //           'assets/images/login/logo/invalid_name.png',
    //           width: 180,
    //           height: 180,
    //         ),
    //         _loginForm()
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _loginForm() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 300,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: MediaQuery.of(context).size.width -
                  (20 + 40), // 两侧padding和右侧元素宽度
              child: FormTestRoute(
                  // currentIndex: widget?.currentIndex,
                  // index: widget?.index,
                  ),
            ),
            // Positioned(
            //   right: 10,
            //   child: Container(
            //     decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            //     width: 40,
            //     padding: EdgeInsets.only(left: 20, top: 70),
            //     height: 300,
            //     child: Text(
            //       '新用户注册',
            //       style: largeTextStyle,
            //     ),
            //   ),
            // )
          ],
        ));
  }
}

class FormTestRoute extends StatefulWidget {
  // int currentIndex;
  // int index;
  // FormTestRoute({Key key, this.currentIndex, this.index}) : super(key: key);
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> with Base {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _unameController.text = '15965899999';
    _pwdController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, state) => Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: true, //开启自动校验
              child: Column(
                children: <Widget>[
                  TextFormField(
                      // autofocus: true,
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          // labelText: "用户名",
                          hintStyle: skyGraySmallTextStyle,
                          hintText: "手机号",
                          errorStyle: smallTextStyle,
                          icon: Icon(Icons.person)),
                      // 校验用户名
                      validator: (v) {
                        return v.trim().length > 0 ? null : "用户名不能为空";
                      }),
                  TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          // labelText: "密码",
                          hintStyle: skyGraySmallTextStyle,
                          hintText: "登录密码",
                          errorStyle: smallTextStyle,
                          icon: Icon(Icons.lock)),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v.trim().length > 5 ? null : "密码不能少于6位";
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text('记住密码'), Text('忘记密码')],
                  ),
                  // 登录按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ButtonWidget(
                            title: '登  录',
                            height: 50,
                            callback: () {
                              //在这里不能通过此方式获取FormState，context不对
                              //print(Form.of(context));
                              // 通过_formKey.currentState 获取FormState后，
                              // 调用validate()方法校验用户名密码是否合法，校验
                              // 通过后再提交数据。
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                // 验证通过提交数据
                                // videos(pageSize: 10,pageNum: 1).then((value) => null);
                                login(
                                    account: _unameController.text,
                                        password: _pwdController.text)
                                    .then((LoginModel res) {
                                      
                                  SpUtil.prefs.setString('token', res.token);
                                  SpUtil.prefs.setString('userId', res.uid);
                                  Navigator.of(context).pop('true');
                                });
                              }
                            },
                          ),
                        ),
                        // largeTextStyle
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
