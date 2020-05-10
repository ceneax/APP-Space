import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<MainState> buildReducer() {
  return asReducer(
    <Object, Reducer<MainState>>{
      MainAction.tabChanged: _onTabChanged,
      MainAction.changeNoticeNum: _changeNoticeNum,
    },
  );
}

MainState _onTabChanged(MainState state, Action action) {
  final MainState newState = state.clone();
  newState.selectedIndex = action.payload;
  return newState;
}

MainState _changeNoticeNum(MainState state, Action action) {
  return state.clone()
    ..noticeNum = action.payload;
}