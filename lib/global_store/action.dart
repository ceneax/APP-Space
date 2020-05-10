import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:space/theme.dart';

enum GlobalAction { changeThemeData, login, logout }

class GlobalActionCreator {

  static Action onChangeThemeData(ThemeType themeType, ThemeData themeData) {
    return Action(GlobalAction.changeThemeData, payload: {
      'themeType': themeType,
      'themeData': themeData
    });
  }

  static Action onLogin(var userInfo) {
    return Action(GlobalAction.login, payload: userInfo);
  }

  static Action onLogout() {
    return Action(GlobalAction.logout);
  }

}
