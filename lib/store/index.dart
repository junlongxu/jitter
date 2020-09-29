// import 'package:flutter/foundation.dart';

// class Store with ChangeNotifier, DiagnosticableTreeMixin {
//   // int _count = 1111111;
//   Map<String, Function> _methods = new Map();
//   // int get count => _count;
//   Map<String, Function> get methods => _methods;

//   void getMethods(String fnName) {
//     if (_methods.containsKey(fnName)) {
//       _methods[fnName]();
//       notifyListeners();
//     }
//   }

//   void setMethods(String fnName, Function fn) {
//       _methods[fnName] = fn;
//       notifyListeners();
//   }
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     // properties.add(IntProperty('count', count));
//     properties.add(ObjectFlagProperty('methods', methods));
//   }
// }
// // Map<String, Function> _methods = new Map();

// // class Provider {
// //   static method(String name, Function fn) {
// //     _methods[name] = fn;
// //   }

// //   static methods(String name) => _methods[name]();
// // }
import 'package:flutter/material.dart';
import 'package:jitter/api/home.dart';
import 'package:jitter/model/user_info.dart';
import 'package:video_player/video_player.dart';
import 'package:jitter/util/eventBus.dart';

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  UserInfo get userInfo => _userInfo;
  String userId;
  UserInfo _userInfo;
  // CounterNotifier() {
  //   increment();
  // }
  Future<UserInfo> _getUserInfo() async {
    var userInfoData = await getUserInfo(userId: userId);
    return userInfoData;
  }

  increment() async{
    _count++;
    _userInfo = await _getUserInfo();
    // 核心方法，通知刷新UI,调用build方法
    notifyListeners();
  }
}

class Store {
  // static get controller {
  //   VideoPlayerController videoPlayerController;
  //   return eventBus.on<VideoPlayerEvent>().listen((VideoPlayerEvent data) {
  //     return data.controller;
  //   });
  // }

  // static controller() {
  //   return eventBus.on<VideoPlayerEvent>().listen((VideoPlayerEvent data) {
  //     return data.controller;
  //   });
  // }
}
