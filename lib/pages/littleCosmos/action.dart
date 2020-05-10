import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

enum LittleCosmosAction { inited, onPageChanged, onTabChanged }

class LittleCosmosActionCreator {

  static Action onInited(TabController tabController) {
    return Action(LittleCosmosAction.inited, payload: tabController);
  }

  static Action onPageChanged(int index) {
    return Action(LittleCosmosAction.onPageChanged, payload: index);
  }

  static Action onTabChanged(int index) {
    return Action(LittleCosmosAction.onTabChanged, payload: index);
  }

}