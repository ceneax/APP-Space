import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/launch/state.dart';

class LaunchHeaderState {

  ThemeData themeData;

  double headerMinHeight, headerMaxHeight, headerWidgetMargin;

  GlobalKey key1, key2, key3;

  var upcomingOne;

  String countText;

}

/// 需要自己写的Connector类
class LaunchHeaderConnector extends ConnOp<LaunchState, LaunchHeaderState> {

  /// 从PageState中获取数据
  @override
  LaunchHeaderState get(LaunchState state) {
    return LaunchHeaderState()
      ..themeData = state.themeData
      ..headerMinHeight = state.headerMinHeight
      ..headerMaxHeight = state.headerMaxHeight
      ..headerWidgetMargin = state.headerWidgetMargin
      ..key1 = state.key1
      ..key2 = state.key2
      ..key3 = state.key3
      ..upcomingOne = state.upcomingOne
      ..countText = state.countText;
  }

  /// 向Page中更新数据
  @override
  void set(LaunchState state, LaunchHeaderState subState) {
  }

}