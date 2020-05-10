import 'package:fish_redux/fish_redux.dart';

enum LookAction { refresh, refreshed, loadMore, loadMoreFinished, goLive, goVideo }

class LookActionCreator {

  static Action onRefresh() {
    return Action(LookAction.refresh);
  }

  static Action onRefreshed(var data) {
    return Action(LookAction.refreshed, payload: data);
  }

  static Action onLoadMore() {
    return Action(LookAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(LookAction.loadMoreFinished, payload: data);
  }

  static Action onGoLive() {
    return Action(LookAction.goLive);
  }

  static Action onGoVideo(var data) {
    return Action(LookAction.goVideo, payload: data);
  }

}
