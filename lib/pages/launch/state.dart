import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class LaunchState implements Cloneable<LaunchState>, GlobalBaseState {

  @override
  ThemeData themeData; /// 无需初始化

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  /// header组件所需的属性
  double headerMinHeight, headerMaxHeight, headerWidgetMargin;
  GlobalKey key1, key2, key3;
  String countText;
  var upcomingOne;

  ScrollController scrollController;

  int currentPage;
  List<dynamic> past;

  Timer timer; /// 不在这里初始化，在effect的init中初始化

  @override
  LaunchState clone() {
    return LaunchState()
      ..themeData = themeData
      ..isLogin = isLogin
      ..userInfo = userInfo
      ..headerMinHeight = headerMinHeight
      ..headerMaxHeight = headerMaxHeight
      ..headerWidgetMargin = headerWidgetMargin
      ..key1 = key1
      ..key2 = key2
      ..key3 = key3
      ..upcomingOne = upcomingOne
      ..countText = countText
      ..scrollController = scrollController
      ..currentPage = currentPage
      ..upcomingOne = upcomingOne
      ..past = past
      ..timer = timer;
  }
}

LaunchState initState(Map<String, dynamic> args) {
  return LaunchState()
    ..headerMinHeight = 0
    ..headerMaxHeight = 0
    ..headerWidgetMargin = 15
    ..key1 = GlobalKey()
    ..key2 = GlobalKey()
    ..key3 = GlobalKey()
    ..countText = '0天 - 0时 - 0分 - 0秒'
    ..scrollController = ScrollController()
    ..currentPage = 1
    ..upcomingOne = {
      'launch_name': '东方红1号',
      'agency': {
        'name': '中国CASC'
      },
      'rocket': {
        'name': '长征一号'
      },
      'launch_net': '1970-04-24T13:35:00Z'
    }
    ..past = [];
}
