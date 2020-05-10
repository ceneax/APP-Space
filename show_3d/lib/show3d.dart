import 'dart:async';
import 'package:flutter/services.dart';

class Show3d {

  static const MethodChannel _channel =
      const MethodChannel('lxiian.space/show3d');

  static Future<String> show3DView(String filePath) async {
    final String result = await _channel.invokeMethod('show3dView', {
      'path': filePath
    });
    return result;
  }

}
