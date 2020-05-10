import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

abstract class GlobalBaseState {
  ThemeData get themeData;
  set themeData(ThemeData themeData);

  dynamic get userInfo;
  set userInfo(var userInfo);

  bool get isLogin;
  set isLogin(bool isLogin);
}

class GlobalState implements Cloneable<GlobalState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin;
  }

}