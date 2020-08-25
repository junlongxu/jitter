import 'package:jitter/model/login.dart';
import 'package:jitter/util/dio.dart';

Future<LoginModel> login({String tel, String, String smscode}) async {
  var result = await DioHttp(
      url: 'login/do', method: 'post', data: {'tel': tel, 'smscode': smscode});
  return LoginModel.fromJson(result);
}

// POST /app/videos/recommendVideos
Future videos({int pageSize, int pageNum}) async {
  var result = await DioHttp(
      url: 'videos/recommendVideos',
      method: 'post',
      data: {'pageSize': pageSize, 'pageNum': pageNum});
  return result;
}
