import 'package:fish_redux/fish_redux.dart';

enum PostDetailOption { MARK, EDIT, DELETE }
enum PostDetailCommentOption { REPORT, DELETE }

enum PostDetailAction { refresh, noPost, refreshed, closePage, loadMore, loadMoreFinished, selectMenu, sendComment, selectCommentMenu, commentDeleted, setCommentId, showReply, sendReply, copyToClipBoard, showImage }

class PostDetailActionCreator {

  static Action onRefresh() {
    return Action(PostDetailAction.refresh);
  }

  static Action onNoPost() {
    return Action(PostDetailAction.noPost);
  }

  static Action onRefreshed(var data) {
    return Action(PostDetailAction.refreshed, payload: data);
  }

  static Action onClosePage() {
    return Action(PostDetailAction.closePage);
  }

  static Action onLoadMore() {
    return Action(PostDetailAction.loadMore);
  }

  static Action onLoadMoreFinished(var data) {
    return Action(PostDetailAction.loadMoreFinished, payload: data);
  }

  static Action onSelectMenu(PostDetailOption value) {
    return Action(PostDetailAction.selectMenu, payload: value);
  }

  static Action onSendComment() {
    return Action(PostDetailAction.sendComment);
  }

  static Action onSelectCommentMenu(PostDetailCommentOption value, int index) {
    return Action(PostDetailAction.selectCommentMenu, payload: {
      'value': value,
      'index': index
    });
  }

  static Action onCommentDeteled(int index) {
    return Action(PostDetailAction.commentDeleted, payload: index);
  }

  static Action onSetCommentId(String commentId) {
    return Action(PostDetailAction.setCommentId, payload: commentId);
  }

  static Action onShowReply(String commentId) {
    return Action(PostDetailAction.showReply, payload: commentId);
  }

  static Action onSendReply(int index) {
    return Action(PostDetailAction.sendReply, payload: index);
  }

  static Action onCopyToClipBoard(String content) {
    return Action(PostDetailAction.copyToClipBoard, payload: content);
  }

  static Action onShowImage(int index, var list) {
    return Action(PostDetailAction.showImage, payload: {
      'index': index,
      'data': list
    });
  }

}
