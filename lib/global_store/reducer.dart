import 'package:fish_redux/fish_redux.dart';
import 'package:space/theme.dart';

import 'package:space/utils/app_util.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeData: _onChangeThemeData,
      GlobalAction.login: _login,
      GlobalAction.logout: _logout,
    },
  );
}

GlobalState _onChangeThemeData(GlobalState state, Action action) {
  if(action.payload['themeType'] != ThemeType.LIGHT_RED_SPECIAL && action.payload['themeType'] != ThemeType.LIGHT_GREY_SPECIAL)
    AppUtil.setThemeToLocal(action.payload['themeType']);

  return state.clone()
    ..themeData = action.payload['themeData'];
}

GlobalState _login(GlobalState state, Action action) {
  AppUtil.setUserInfoToLocal(action.payload);
  return state.clone()
    ..isLogin = true
    ..userInfo = action.payload;
}

GlobalState _logout(GlobalState state, Action action) {
  AppUtil.cleanLocalUserInfo();
  return state.clone()
    ..isLogin = false
    ..userInfo = {};
}