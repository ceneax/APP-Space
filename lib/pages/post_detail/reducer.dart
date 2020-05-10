import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PostDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<PostDetailState>>{
      PostDetailAction.noPost: _noPost,
      PostDetailAction.refreshed: _refreshed,
      PostDetailAction.loadMoreFinished: _loadMoreFinished,
      PostDetailAction.commentDeleted: _commentDeleted,
      PostDetailAction.setCommentId: _setCommentId,
    },
  );
}

PostDetailState _noPost(PostDetailState state, Action action) {
  return state.clone()
    ..existPost = false;
}

PostDetailState _refreshed(PostDetailState state, Action action) {
  return state.clone()
    ..existPost = true
    ..currentPage = 1
    ..comments = action.payload;
}

PostDetailState _loadMoreFinished(PostDetailState state, Action action) {
  var tmpComments = state.comments;
  tmpComments.addAll(action.payload);

  return state.clone()
    ..currentPage = state.currentPage + 1
    ..comments = tmpComments;
}

PostDetailState _commentDeleted(PostDetailState state, Action action) {
  var tmpComments = state.comments;
  tmpComments.removeAt(action.payload);

  return state.clone()
    ..comments = tmpComments;
}

PostDetailState _setCommentId(PostDetailState state, Action action) {
  return state.clone()
    ..commentId = action.payload;
}