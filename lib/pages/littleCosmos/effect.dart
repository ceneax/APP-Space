import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'action.dart';
import 'state.dart';

Effect<LittleCosmosState> buildEffect() {
  return combineEffects(<Object, Effect<LittleCosmosState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    LittleCosmosAction.onTabChanged: _onTabChanged,
    LittleCosmosAction.onPageChanged: _onPageChanged,
  });
}

void _init(Action action, Context<LittleCosmosState> ctx) {
  /// 初始化tabController
  ctx.dispatch(LittleCosmosActionCreator.onInited(TabController(
    length: ctx.state.tabs.length,
    vsync: ctx.stfState as TickerProvider
  )));
}

void _dispose(Action action, Context<LittleCosmosState> ctx) {
  ctx.state.pageController.dispose();
  ctx.state.tabController.dispose();
}

void _onTabChanged(Action action, Context<LittleCosmosState> ctx) {
  ctx.state.pageController.jumpToPage(action.payload);
}

void _onPageChanged(Action action, Context<LittleCosmosState> ctx) {
  ctx.state.tabController.animateTo(action.payload);
}