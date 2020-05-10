import 'package:fish_redux/fish_redux.dart';

import 'package:space/theme.dart';

import 'reducer.dart';
import 'state.dart';

/// 建立一个AppStore
class GlobalStore {

  static Store<GlobalState> _globalStore;

  static Store<GlobalState> get store =>
      _globalStore ??= createStore<GlobalState>(GlobalState()
        ..userInfo = {}
        ..isLogin = false
        ..themeData = ThemeStyle.lightThemeDefault
          , buildReducer());

}