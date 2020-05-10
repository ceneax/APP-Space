import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';
import 'package:space/pages/launch/action.dart';

class LaunchDetailState implements Cloneable<LaunchDetailState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  LaunchStatus launchStatus;
  var data;

  double expandedHeight;

  @override
  LaunchDetailState clone() {
    return LaunchDetailState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..launchStatus = launchStatus
      ..data = data
      ..expandedHeight = expandedHeight;
  }
}

LaunchDetailState initState(Map<String, dynamic> args) {
  return LaunchDetailState()
    ..launchStatus = args['type']
    ..data = args['data']
    ..expandedHeight = 0;
}
