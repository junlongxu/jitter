import 'package:flutter/material.dart';

// 强制更新底部弹窗内的状态
class UpdateBottomSheet {
  // final Widget child;
  // const UpdateBottomSheet({this.child});
  static stateBuild({Widget child}) {
    return StatefulBuilder(builder: (context, state) => child);
  }
}
