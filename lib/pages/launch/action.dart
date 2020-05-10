import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

enum LaunchStatus { UPCOMING, PAST }

enum LaunchAction { init, loadMore, loadMoreFinished, refresh, resetData, updateCounter, itemClick, jumpToTop }

class LaunchActionCreator {

  static Action onInit() {
    return Action(LaunchAction.init);
  }

  static Action onLoadMore() {
    return Action(LaunchAction.loadMore);
  }

  static Action onLoadMoreFinished(List<dynamic> data) {
    /// 有payload参数的时候一定不要忘了在这里加上！！！！
    /// 前面都没忘，居然到这里给忘了，害的找了半天原因 = = ，自闭了都。。
    return Action(LaunchAction.loadMoreFinished, payload: data);
  }

  static Action onRefresh() {
    return Action(LaunchAction.refresh);
  }

  static Action onResetData(List<dynamic> data) {
    return Action(LaunchAction.resetData, payload: data);
  }

  static Action onUpdateCounter(String data) {
    return Action(LaunchAction.updateCounter, payload: data);
  }

  static Action onItemClick(int index) {
    return Action(LaunchAction.itemClick, payload: index);
  }
  static Action onJumpToTop() {
    return Action(LaunchAction.jumpToTop);
  }


}
