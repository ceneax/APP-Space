import 'dart:convert';

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space/theme.dart';

class AppUtil {

  /// 将登陆后的用户信息保存到本地
  static void setUserInfoToLocal(var userInfo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userData', jsonEncode(userInfo));
  }

  /// 从本地获取用户信息
  static Future<dynamic> getUserInfoFromLocal() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userInfo = sp.getString('userData');

    if(userInfo == null || userInfo == '') {
      return null;
    }
    return Future.value(jsonDecode(userInfo));
  }

  /// 清除本地登录信息
  static void cleanLocalUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('userData');
  }

  /// 获取app当前versionName和versionCode
  static Future<Map<String, String>> getAppVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, String> result = {
      'versionName': packageInfo.version,
      'versionCode': packageInfo.buildNumber
    };

    return Future.value(result);
  }

  /// 将主题信息保存到本地
  static void setThemeToLocal(ThemeType themeType) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('themeType', themeType.index);
  }

  /// 从本地取出主题信息
  static Future<ThemeType> getThemeFromLocal() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int index = sp.getInt('themeType');

    if(index == null || index >= ThemeType.values.length || index < 0) {
      return Future.value(ThemeType.LIGHT_DEFAULT);
    }
    return Future.value(ThemeType.values[index]);
  }

}