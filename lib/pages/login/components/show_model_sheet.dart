import 'package:flutter/material.dart';
import 'package:jitter/pages/login/index.dart';

class ShowModelSheet {
  static Future<void> showLogin(BuildContext context) => showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext sheetContext) => LoginPage(),
      );
}
