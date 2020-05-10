import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class DiscuzState implements Cloneable<DiscuzState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  List<dynamic> posts;
  int currentPage;

  @override
  DiscuzState clone() {
    return DiscuzState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..posts = posts
      ..currentPage = currentPage;
  }

}

DiscuzState initState(Map<String, dynamic> args) {
  return DiscuzState()
    ..posts = []
    ..currentPage = 1;
}
