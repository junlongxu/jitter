import 'package:flutter/material.dart';
import 'package:jitter/api/login.dart';
import 'package:jitter/util/base.dart';

class LoginPage extends StatefulWidget {
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
      padding: EdgeInsets.all(boundarySize),
      decoration: BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage('assets/images/login/background/invalid_name.png'),
            fit: BoxFit.cover),
      ),
      child: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/login/logo/invalid_name.png',
              width: 180,
              height: 180,
            ),
            _loginForm()
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 300,
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width -
                    (20 + 40), // 两侧padding和右侧元素宽度
                child: FormTestRoute()),
            Positioned(
              right: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                width: 40,
                padding: EdgeInsets.only(left: 20, top: 70),
                height: 300,
                child: Text(
                  '新用户注册',
                  style: largeTextStyle,
                ),
              ),
            )
          ],
        ));
  }
}

class FormTestRoute extends StatefulWidget {
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
    _unameController.text = '13254658795';
    _pwdController.text = '111111';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidate: true, //开启自动校验
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: true,
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
                    child: containerGradient(
                  height: null,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.transparent, // 设为透明色
                    elevation: 0, // 正常时阴影隐藏
                    highlightElevation: 0, // 点击时阴影隐藏
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        login(
                                tel: _unameController.text,
                                smscode: _pwdController.text)
                            .then((res) {
                              
                            });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        '登 录',
                        style: largeTextStyle,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
