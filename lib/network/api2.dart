import 'package:dio/dio.dart';

import 'package:space/config.dart';

/// 获取发射记录的api请求库
class Api2 {

  Dio _dio;
  static Api2 _instance;

  static Api2 getInstance() {
    return _instance ??= Api2();
  }

  Api2() {
    _dio = Dio(BaseOptions(
      baseUrl: Config.PARSE_LAUNCH_SERVER_URL,
      headers: {
        'X-Parse-Application-Id': Config.PARSE_LAUNCH_APP_ID,
        'X-Parse-REST-API-Key': Config.PARSE_LAUNCH_REST_KEY
      },
    ));
  }

  /// 获取即将发射列表
  Future<dynamic> getUpcoming({int page = 1}) async {
    try {
      Response response = await _dio.post('/functions/queryLaunch', data: {
        't': 1,
        'p': page
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取已发射列表
  Future<dynamic> getPast(int page) async {
    try {
      Response response = await _dio.post('/functions/queryLaunch', data: {
        'p': page,
        't': 0
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取科普列表
  Future<dynamic> getPolularScience(int page, int type) async {
    try {
      Response response = await _dio.post('/functions/queryPolularScience', data: {
        'p': page,
        't': type
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取科普详情
  Future<dynamic> getPolularScienceDetail(String id) async {
    try {
      Response response = await _dio.get('/classes/PolularScience/$id');
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

}