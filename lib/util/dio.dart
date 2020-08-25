import 'package:dio/dio.dart';
import 'dart:convert';

class BaseUrl {
  // 配置默认请求地址
  static const String url = 'http://172.24.135.25:8001/app/';
}

Future DioHttp(
    {String url,
    method,
    Map<String, dynamic> data,
    Map<String, dynamic> headers}) async {
  if (url.isEmpty) return;
  String baseUrl;
  Response response;
  if (!url.startsWith('http')) {
    baseUrl = '${BaseUrl.url}$url';
  }
  try {
    Map<String, dynamic> dataMap = data == null ? new Map() : data;
    Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
    // headersMap['token'] = getToken();
    Dio dio = new Dio();
    dio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
    dio.options.receiveTimeout = 3000; // 响应流上前后两次接受到数据的间隔，毫秒
    dio.options.headers.addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加
    if (method == 'get') {
      response = await dio.get(baseUrl);
    } else if (method == 'post') {
      FormData formData = new FormData.fromMap(dataMap);
      response = await dio.post(baseUrl, data: formData);
    }

    if (response.statusCode != 200) {
      return false;
    }
    Map<String, dynamic> resDataMap = response.data;
    String _msg = resDataMap['msg'];
    String _code = resDataMap['code'];
    String _resData = resDataMap['data'];
    if (_code != 200) {
      if (_code == 500) {
        return _msg;
      }
    } else {
      Utf8Decoder utf8decoder = Utf8Decoder();
      return jsonDecode(_resData);
    }
  } catch (err) {
    return '数据请求错误$err.toString';
  }
}
