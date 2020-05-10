import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'package:space/config.dart';

/// 上传图片
class Api3 {

  Dio _dio;
  static Api3 _instance;

  static Api3 getInstance() {
    return _instance ??= Api3();
  }

  Api3() {
    _dio = Dio();
  }

  /// 又拍云鉴权
  Map<String, dynamic> _UPYSignature(File file, String cloudPath) {
    DateTime date = DateTime.now();

    String p = '8960e3473b54bf6a7bd37868da7eac39';
    String m = 'POST';
    String u = '/app-space$cloudPath';
    String b = 'app-space';
    String s = '$cloudPath/${date.millisecondsSinceEpoch}-${md5.convert(utf8.encode(file.path))}.${file.path.split('.').last}';
    String d = HttpDate.format(date);
    String e = date.add(Duration(minutes: 30)).millisecondsSinceEpoch.toString();

    String policy = base64.encode(utf8.encode(jsonEncode({
      'bucket': b,
      'save-key': s,
      'expiration': e,
      'date': d,
      'x-gmkerl-thumb': '/quality/40'
    })));

    var hmacSha1 = Hmac(sha1, utf8.encode(p));
    var digest = hmacSha1.convert(utf8.encode('$m&$u&$d&$policy'));

    return {
      'url': u,
      'sign': base64.encode(digest.bytes),
      'policy': policy
    };
  }

  /// 上传图片
  Future<dynamic> uploadFile(File f, String cloudPath) async {
    var data = _UPYSignature(f, cloudPath);

    FormData formData = FormData.fromMap({
      'authorization': 'UPYUN lxiian:${data['sign']}',
      'policy': data['policy'],
      'file': await MultipartFile.fromFile(f.path)
    });

    try {
      Response response = await _dio.post('http://v0.api.upyun.com${data['url']}', data: formData);
      if(response.statusCode == 200)
        return Future.value('${Config.UPY_STORAGE_HOST}${jsonDecode(response.data)['url']}');
      else
        return Future.value(false);
    } on DioError catch(e) {
      return Future.value(false);
    }
  }

}