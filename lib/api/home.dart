// import 'package:jitter/model/login.dart';
// import 'package:jitter/model/base_state.dart';
import 'package:jitter/model/follow_list.dart';
import 'package:jitter/model/user_info.dart';
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

// GET /app/userInfo/userInfo获取用户详情
Future<UserInfo> getUserInfo({String userId}) async {
  var json = await DioHttp(
      url: 'userInfo/userInfo', method: 'get', data: {'userId': userId});
  return UserInfo.fromJson(json);
}
// -----------------------------------------------关注按钮--------------------------
// POST /app/userFocus/add 点击按钮关注用户
Future<Null> addFollowUsers({String userId}) async {
  var stateNull = await DioHttp(
      url: 'userFocus/add', method: 'post', data: {'followUserId': userId});
  return stateNull;
}
// POST /app/userFocus/add 点击按钮取消已关注用户
Future<Null> delFollowUsers({String userId}) async {
  var stateNull = await DioHttp(
      url: 'userFocus/delete', method: 'get', data: {'userId': userId});
  return stateNull;
}


// GET /app/userFocus/list用户关注的关注列表
Future<FollowFans> focusData({int pageSize = 10, int pageNum = 1,String userId}) async {
  var json = await DioHttp(
      url: 'userFocus/list', method: 'get', data: {'userId': userId, 'pageNum': pageNum, 'pageSize': pageSize});
  return FollowFans.fromJson(json);
}

// GET /app/userFocus/list用户粉丝列表
Future<FollowFans> fansData({int pageSize = 10, int pageNum = 1,String userId}) async {
  var json = await DioHttp(
      url: 'userFans/list', method: 'get', data: {'userId': userId, 'pageNum': pageNum, 'pageSize': pageSize});
  return FollowFans.fromJson(json);
}