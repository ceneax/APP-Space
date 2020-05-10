import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class RegisterState implements Cloneable<RegisterState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  String username, nickname, password;
  int dropDownButtonValue;

  @override
  RegisterState clone() {
    return RegisterState()
      ..themeData = themeData
      ..isLogin = isLogin
      ..userInfo = userInfo
      ..username = username
      ..nickname = nickname
      ..password = password
      ..dropDownButtonValue = dropDownButtonValue;
  }

}

RegisterState initState(Map<String, dynamic> args) {
  return RegisterState();
}
