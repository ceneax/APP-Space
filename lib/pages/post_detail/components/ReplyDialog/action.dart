import 'package:fish_redux/fish_redux.dart';

enum PostDetailReplyDialogUpdateOption { SET, ADD, DELETE, CLEAN }
enum PostDetailReplyDialogOption { REPORT, DELETE }

enum PostDetailReplyDialogAction { setReplies, loadMore, loadMoreFinished, deleteReply, deletedReply, dispose, sendReply, copyToClipBoard }

class PostDetailReplyDialogActionCreator {

  static Action onSetReplies(var data) {
    return Action(PostDetailReplyDialogAction.setReplies, payload: data);
  }

  static Action onLoadMore() {
    return Action(PostDetailReplyDialogAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(PostDetailReplyDialogAction.loadMoreFinished, payload: data);
  }

  static Action onDeleteReply(PostDetailReplyDialogOption value, int index) {
    return Action(PostDetailReplyDialogAction.deleteReply, payload: {
      'value': value,
      'index': index
    });
  }

  static Action onDeletedReply(int index) {
    return Action(PostDetailReplyDialogAction.deletedReply, payload: index);
  }

  static Action onDispose() {
    return Action(PostDetailReplyDialogAction.dispose);
  }

  static Action onSendReply(int index) {
    return Action(PostDetailReplyDialogAction.sendReply, payload: index);
  }

  static Action onCopyToClipBoard(String content) {
    return Action(PostDetailReplyDialogAction.copyToClipBoard, payload: content);
  }

}
