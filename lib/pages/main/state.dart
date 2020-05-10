import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';
import 'package:space/routes/routes.dart';

class MainState implements Cloneable<MainState>, GlobalBaseState {

  @override
  ThemeData themeData; /// 无需初始化

  @override
  dynamic userInfo; /// 无需初始化

  @override
  bool isLogin; /// 无需初始化

  int selectedIndex;
  PageController pageController;
  List<Widget> pages;

  int noticeNum;

  @override
  MainState clone() {
    return MainState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..selectedIndex = selectedIndex
      ..pageController = pageController
      ..pages = pages
      ..noticeNum = noticeNum;
  }
}

/// 这里初始化本类中变量的初始值
MainState initState(Map<String, dynamic> args) {
  return MainState()
    ..selectedIndex = 0
    ..pageController = PageController()
    ..pages = List<Widget>.unmodifiable([
      Routes.routes.buildPage('launch_page', null),
      Routes.routes.buildPage('little_cosmos_page', null),
      Routes.routes.buildPage('me_page', null),
    ])
    ..noticeNum = 0;
}