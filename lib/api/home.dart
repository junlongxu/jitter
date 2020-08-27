// import 'package:jitter/model/login.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/util/dio.dart';

// POST /app/videos/recommendVideos推荐的视频列表
Future<VideosModel> getVideos({int pageSize = 10, int pageNum = 1}) async {
  var json = await DioHttp(
      url: 'videos/recommendVideos',
      method: 'post',
      data: {'pageSize': pageSize, 'pageNum': pageNum});
  return VideosModel.fromJson(json);
}
