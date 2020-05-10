import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Reducer<LaunchState> buildReducer() {
  return asReducer(
    <Object, Reducer<LaunchState>>{
      LaunchAction.init: _init,
      LaunchAction.resetData: _resetData,
      LaunchAction.updateCounter: _updateCounter,
      LaunchAction.loadMoreFinished: _loadMoreFinished,
    },
  );
}

LaunchState _init(LaunchState state, Action action) {
  final LaunchState newState = state.clone();

  newState.headerMinHeight =
      WidgetUtil.getStatusBarHeight() + (state.headerWidgetMargin * 3) +
          WidgetUtil.getWidgetHeight(state.key1) + WidgetUtil.getWidgetHeight(state.key2);
  newState.headerMaxHeight = newState.headerMinHeight + WidgetUtil.getWidgetHeight(state.key3) + state.headerWidgetMargin;

  return newState;
}

LaunchState _resetData(LaunchState state, Action action) {
  final LaunchState newState = state.clone();
  var upcoming = action.payload[0];
  var past = action.payload[1];

  if(upcoming != null) {
    newState.upcomingOne = upcoming[0];
  } else {
    newState.upcomingOne = state.upcomingOne;
  }

  if(past != null) {
    newState.past = past;
    newState.currentPage = 1;
  } else {
    newState.past = state.past;
    newState.currentPage = state.currentPage;
  }

  return newState;
}

LaunchState _updateCounter(LaunchState state, Action action) {
  return state.clone()
    ..countText = action.payload;
}

LaunchState _loadMoreFinished(LaunchState state, Action action) {
  var tmpPast = state.past;
  tmpPast.addAll(action.payload);

  return state.clone()
    ..past = tmpPast
    ..currentPage = state.currentPage + 1;
}