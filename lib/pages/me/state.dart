import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class MeState implements Cloneable<MeState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  String versionName;

  List<String> menu;

  /// component需要的属性
  List<dynamic> notice;
  int noticeCurrentPage;

  @override
  MeState clone() {
    return MeState()
      ..themeData = themeData
      ..isLogin = isLogin
      ..userInfo = userInfo
      ..versionName = versionName
      ..menu = menu
      ..notice = notice
      ..noticeCurrentPage = noticeCurrentPage;
  }

}

MeState initState(Map<String, dynamic> args) {
  return MeState()
    ..versionName = '0.0.0'
    ..menu = ['消息通知', '回复我的', '操作', '我的主页', '换个心情', '退出登录']
    ..notice = []
    ..noticeCurrentPage = 1;
}