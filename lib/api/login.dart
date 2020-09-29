import 'package:jitter/model/login.dart';
import 'package:jitter/util/dio.dart';

Future<LoginModel> login({String account, String password}) async {
  var result = await DioHttp(
      url: 'login/login', method: 'post', data: {'account': account, 'password': password, 'originType': '1'});
  return LoginModel.fromJson(result);
}


