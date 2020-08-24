import 'package:flutter/material.dart';

/// 单独修改了bottomSheet组件的高度
import 'package:jitter/dart/bottomSheet.dart' as CustomBottomSheet;

class BottomsheetUtil {
  static Future<T> sheet<T>({BuildContext context, Widget child}) {
    CustomBottomSheet.showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (context) => child);
  }
}
