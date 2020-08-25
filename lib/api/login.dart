import 'package:jitter/util/dio.dart';

Future login({String  tel, String, String smscode }) async {
  var result = await DioHttp(
    url: 'login/do',
    method: 'post',
    data: {tel: tel, smscode: smscode}
  );
  return result;
}
