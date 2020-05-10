import 'package:fish_redux/fish_redux.dart';

enum MeNoticeDialogUpdateType { SET, ADD, CLEAN }

enum MeNoticeDialogAction { setNotice, loadMore, loadMoreFinished, dispose, jumpToPostDetail }

class MeNoticeDialogActionCreator {

  static Action onSetNotice(var data) {
    return Action(MeNoticeDialogAction.setNotice, payload: data);
  }

  static Action onLoadMore() {
    return Action(MeNoticeDialogAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(MeNoticeDialogAction.loadMoreFinished, payload: data);
  }

  static Action onDispose() {
    return Action(MeNoticeDialogAction.dispose);
  }

  static Action onJumpToPostDetail(int index) {
    return Action(MeNoticeDialogAction.jumpToPostDetail, payload: index);
  }

}
