import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';
import 'package:space/routes/routes.dart';

import '../../routes/routes.dart';
import '../../routes/routes.dart';

class LittleCosmosState implements Cloneable<LittleCosmosState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  List<String> tabs;
  int tabIndex;

  List<Widget> pages;

  PageController pageController;
  TabController tabController; /// 不在这里初始化

  @override
  LittleCosmosState clone() {
    return LittleCosmosState()
      ..themeData = themeData
      ..isLogin = isLogin
      ..userInfo = userInfo
      ..tabs = tabs
      ..tabIndex = tabIndex
      ..pages = pages
      ..pageController = pageController
      ..tabController = tabController;
  }

}

LittleCosmosState initState(Map<String, dynamic> args) {
  return LittleCosmosState()
    ..tabs = ['交流', '看一看', '科普', '浩瀚']
    ..tabIndex = 0
    ..pages = List<Widget>.unmodifiable([
      Routes.routes.buildPage('discuz_page', null),
      Routes.routes.buildPage('look_page', null),
      Routes.routes.buildPage('polular_science_page', null),
      Routes.routes.buildPage('vast_page', null),
    ])
    ..pageController = PageController();
}
