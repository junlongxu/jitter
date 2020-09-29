import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/util/sp_util.dart';
import 'package:jitter/widgets/web_view_widget.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with Base {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getToken(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            // width: 0,
            // height: 0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/task/mask/invalid_name.png'),
                fit: BoxFit.fill,
              ),
            ),
          );
        } else if (snapshot.data != null) {
          return Container(
            color: themeColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: WebViewWidget(
              // url: 'http://www.11wy.top/taskpage/#/task?token=${snapshot.data}',
              // url: 'http://172.24.136.31:8012/#/task?token=ae97f698acafaf97c6007ed46b3e413a',
              url:
                  'http://172.24.135.209/taskpage/#/task?token=15be2997cb1df637d91e36e08a0ec35d',
            ),
          );
        }
      },
    );
  }

  Future<String> getToken() async {
    return SpUtil.prefs.getString('token');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// import 'package:flutter/material.dart';
// import 'package:jitter/pages/mypage/components/user_top_msg.dart';
// import 'package:jitter/util/base.dart';

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> with Base {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: themeColor,
//       padding: EdgeInsets.fromLTRB(boundarySize, 20, boundarySize, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[UserTopMsg()],
//       ),
//     );
//   }
// }
