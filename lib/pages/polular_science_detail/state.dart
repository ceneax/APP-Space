import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class PolularScienceDetailState implements Cloneable<PolularScienceDetailState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  String id;
  String title;
  String data;

  @override
  PolularScienceDetailState clone() {
    return PolularScienceDetailState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..id = id
      ..title = title
      ..data = data;
  }

}

PolularScienceDetailState initState(Map<String, dynamic> args) {
  return PolularScienceDetailState()
    ..id = args['id']
    ..title = args['title']
    ..data = '';
}