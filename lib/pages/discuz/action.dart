import 'package:fish_redux/fish_redux.dart';

enum DisCuzPostOption { REPORT }

enum DiscuzAction { refresh, reset, loadMore, loadMoreFinished, newPostPage, postDetailPage, showImage }

class DiscuzActionCreator {

  static Action onRefresh() {
    return Action(DiscuzAction.refresh);
  }

  static Action onReset(var data) {
    return Action(DiscuzAction.reset, payload: data);
  }

  static Action onLoadMore() {
    return Action(DiscuzAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(DiscuzAction.loadMoreFinished, payload: data);
  }

  static Action onNewPostPage() {
    return Action(DiscuzAction.newPostPage);
  }

  static Action onPostDetailPage(int index) {
    return Action(DiscuzAction.postDetailPage, payload: index);
  }

  static Action onShowImage(int index, var list) {
    return Action(DiscuzAction.showImage, payload: {
      'index': index,
      'data': list
    });
  }

}
