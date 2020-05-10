import 'package:flutter/material.dart' hide Action;

import 'package:space/global_store/action.dart';
import 'package:space/network/api.dart';
import 'package:space/theme.dart';
import 'package:space/utils/app_util.dart';
import 'global_store/store.dart';

import 'app.dart';

void main() async {
  /// If you're running an application and need to access the binary messenger before `runApp()` has been called (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化用户信息
  var userInfo = await AppUtil.getUserInfoFromLocal();
  if(userInfo == null) {
    GlobalStore.store.dispatch(GlobalActionCreator.onLogout());
  } else {
    GlobalStore.store.dispatch(GlobalActionCreator.onLogin(userInfo));
  }

  /// 初始化主题
  ThemeType themeType = await AppUtil.getThemeFromLocal();
  ThemeData themeData = ThemeStyle.lightThemeDefault;

  if(themeType == ThemeType.LIGHT_DEFAULT)
    themeData = ThemeStyle.lightThemeDefault;
  else if(themeType == ThemeType.LIGHT_RED)
    themeData = ThemeStyle.lightThemeRed;
  else if(themeType == ThemeType.LIGHT_GREEN)
    themeData = ThemeStyle.lightThemeGreen;
  else if(themeType == ThemeType.LIGHT_RED_SPECIAL)
    themeData = ThemeStyle.lightThemeRedSpecial;
  else if(themeType == ThemeType.LIGHT_GREY_SPECIAL)
    themeData = ThemeStyle.lightThemeGreySpecial;
  else if(themeType == ThemeType.DARK_DEFAULT)
    themeData = ThemeStyle.darkThemeDefault;

  var remoteTheme = await Api.getInstance().getTheme();
  if(remoteTheme is int) {
    /// do nothing，什么都不做
  } else {
    if(remoteTheme['enable']) {
      switch(remoteTheme['type']) {
        case 4:
          themeData = ThemeStyle.lightThemeRedSpecial;
          break;
        case 5:
          themeData = ThemeStyle.lightThemeGreySpecial;
          break;
      }
    }
  }

  GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeData(themeType, themeData));

  /// 开始渲染主程序
  runApp(createApp());
}