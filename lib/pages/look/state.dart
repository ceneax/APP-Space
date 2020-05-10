import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../global_store/state.dart';

class LookState implements Cloneable<LookState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  ScrollController scrollController;

  var videos;
  int currentPage;

  @override
  LookState clone() {
    return LookState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..scrollController = scrollController
      ..videos = videos
      ..currentPage = currentPage;
  }
}

LookState initState(Map<String, dynamic> args) {
  return LookState()
    ..scrollController = ScrollController()
    ..videos = []
    ..currentPage = 1;
}
