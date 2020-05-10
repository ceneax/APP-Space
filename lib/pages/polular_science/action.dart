import 'package:fish_redux/fish_redux.dart';

enum PolularScienceAction { itemClick, indexChanged, refresh, refreshed, loadMore, loadMoreFinished, listSelect }

class PolularScienceActionCreator {

  static Action onItemClick(int index) {
    return Action(PolularScienceAction.itemClick, payload: index);
  }

  static Action onIndexChanged(int index) {
    return Action(PolularScienceAction.indexChanged, payload: index);
  }

  static Action onRefresh() {
    return Action(PolularScienceAction.refresh);
  }

  static Action onRefreshed(var data) {
    return Action(PolularScienceAction.refreshed, payload: data);
  }

  static Action onLoadMore() {
    return Action(PolularScienceAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(PolularScienceAction.loadMoreFinished, payload: data);
  }

  static Action onListSelect(int index) {
    return Action(PolularScienceAction.listSelect, payload: index);
  }

}
