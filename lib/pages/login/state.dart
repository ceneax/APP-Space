import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class LoginState implements Cloneable<LoginState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  String username, password;

  @override
  LoginState clone() {
    return LoginState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..username = username
      ..password = password;
  }
}

LoginState initState(Map<String, dynamic> args) {
  return LoginState(); /// 初始化的话，就随意吧，我反正是不打算初始化那两个属性，可有可无
}