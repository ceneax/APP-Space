import 'package:dio/dio.dart';

import 'package:space/config.dart';

/// 获取社交数据的api请求库
class Api {

  Dio _dio;
  static Api _instance;

  static Api getInstance() {
    return _instance ??= Api();
  }

  Api() {
    _dio = Dio(BaseOptions(
      baseUrl: Config.PARSE_SPACE_SERVER_URL,
      headers: {
        'X-Parse-Application-Id': Config.PARSE_SPACE_APP_ID,
        'X-Parse-REST-API-Key': Config.PARSE_SPACE_REST_KEY
      },
    ));
  }

/// 检查获取结果
//  Future<dynamic> _checkResponse(Response response) {
//    var res = response.data;
//
//    if(response.statusCode >= 200 && response.statusCode <= 299) { // http响应成功，且数据执行或返回成功
//      return Future.value(res);
//    } else {
//      if(res['code'] == null) { // http相应失败
//        return Future.value(response.statusCode);
//      } else { // http响应成功，但服务器执行数据返回内容为失败
//        return Future.value(res['code']);
//      }
//    }
//  }

  /// 注册
  Future<dynamic> register(String username, String nickname, String password, String sex) async {
    try {
      Response response = await _dio.post('/users', options: Options(headers: {
        'X-Parse-Revocable-Session': '1'
      }), data: {
        'username': username,
        'nickname': nickname,
        'password': password,
        'sex': sex
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 登陆
  Future<dynamic> login(String username, String password) async {
    try {
      Response response = await _dio.get('/login', options: Options(headers: {
        'X-Parse-Revocable-Session': '1'
      }), queryParameters: {
        'username': username,
        'password': password
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 发帖
  Future<dynamic> sendPost(String content, String user, String session, {var image}) async {
    if(image == null)
      image = [];

    try {
      Response response = await _dio.post('/classes/Post', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'content': content,
        'image': image,
        'author': {
          '__type': 'Pointer',
          'className': '_User',
          'objectId': user
        },
        'ACL': {
          user: {
            'read': true,
            'write': true
          },
          '*': {
            'read': true
          }
        }
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取指定页码的帖子
  Future<dynamic> getPosts(int page) async {
    try {
      Response response = await _dio.post('/functions/queryPost', data: {
        'p': page
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 发评论
  Future<dynamic> sendComment(String content, String post, String user, String session) async {
    try {
      Response response = await _dio.post('/classes/Comment', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'content': content,
        'post': {
          '__type': 'Pointer',
          'className': 'Post',
          'objectId': post
        },
        'author': {
          '__type': 'Pointer',
          'className': '_User',
          'objectId': user
        },
        'ACL': {
          user: {
            'read': true,
            'write': true
          },
          '*': {
            'read': true
          }
        }
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取评论
  Future<dynamic> getComments(int page, String post, int sort) async {
    try {
      Response response = await _dio.post('/functions/queryComment', data: {
        'p': page,
        'post': {
          '__type': 'Pointer',
          'className': 'Post',
          'objectId': post
        },
        's': sort
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 发送回复
  Future<dynamic> sendReply(String content, String comment, String user, String session, {String reply}) async {
    var body = {
      'content': content,
      'comment': {
        '__type': 'Pointer',
        'className': 'Comment',
        'objectId': comment
      },
      'author': {
        '__type': 'Pointer',
        'className': '_User',
        'objectId': user
      },
      'ACL': {
        user: {
          'read': true,
          'write': true
        },
        '*': {
          'read': true
        }
      }
    };

    if(reply != null && reply != '') {
      body.addAll({
        'reply': {
          '__type': 'Pointer',
          'className': 'Reply',
          'objectId': reply
        }
      });
    }

    try {
      Response response = await _dio.post('/classes/Reply', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: body);
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取回复
  Future<dynamic> getReplies(int page, String comment) async {
    try {
      Response response = await _dio.post('/functions/queryReply', data: {
        'p': page,
        'comment': {
          '__type': 'Pointer',
          'className': 'Comment',
          'objectId': comment
        }
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 删除指定表的指定记录
  Future<dynamic> delete(String className, String objectId, String session) async {
    try {
      Response response = await _dio.delete('/classes/$className/$objectId', options: Options(headers: {
        'X-Parse-Session-Token': session
      }));
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 查询新消息数量
  Future<dynamic> checkNotification(String session, String userId) async {
    try {
      Response response = await _dio.post('/functions/chackNotification', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'u': userId
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 通过session重新拉取最新的用户信息
  Future<dynamic> retrieveUserInfo(String session) async {
    try {
      Response response = await _dio.get('/users/me', options: Options(headers: {
        'X-Parse-Session-Token': session
      }));
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 更新用户信息
  Future<dynamic> updateUserInfo(String session, String userId, String avatar) async {
    try {
      Response response = await _dio.put('/users/$userId', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'avatar': avatar
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 检测帖子是否存在
  Future<dynamic> checkPost(String postId) async {
    try {
      Response response = await _dio.get('/classes/Post/$postId');
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取消息通知
  Future<dynamic> getNotifications(String session, String userId, int page) async {
    try {
      Response response = await _dio.post('/functions/queryNotification', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'p': page,
        'u': userId
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 将未读消息设置为已读
  Future<dynamic> changeNotification(String session, String userId) async {
    try {
      Response response = await _dio.post('/functions/changeNotification', options: Options(headers: {
        'X-Parse-Session-Token': session
      }), data: {
        'u': userId
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取视频列表
  Future<dynamic> getVideo(int page) async {
    try {
      Response response = await _dio.post('/functions/queryVideo', data: {
        'p': page
      });
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取直播状态
  Future<dynamic> getLive() async {
    try {
      Response response = await _dio.get('/classes/Live/${Config.LIVE_OBJECT_ID}');
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取最新版本信息
  Future<dynamic> getVersion() async {
    try {
      Response response = await _dio.get('/classes/Update/${Config.UPDATE_OBJECT_ID}');
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

  /// 获取主题信息
  Future<dynamic> getTheme() async {
    try {
      Response response = await _dio.get('/classes/Theme/${Config.THEME_OBJECT_ID}');
      return Future.value(response.data);
    } on DioError catch(e) {
      return Future.value(e.response.statusCode);
    }
  }

}