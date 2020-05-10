import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PostDetailReplyDialogState> buildReducer() {
  return asReducer(
    <Object, Reducer<PostDetailReplyDialogState>>{
      PostDetailReplyDialogAction.setReplies: _setReplies,
      PostDetailReplyDialogAction.loadMoreFinished: _loadMoreFinished,
      PostDetailReplyDialogAction.deletedReply: _deletedReply,
      PostDetailReplyDialogAction.dispose: _dispose,
    },
  );
}

PostDetailReplyDialogState _setReplies(PostDetailReplyDialogState state, Action action) {
  return PostDetailReplyDialogState()
    ..replies = action.payload
    ..updateOption = PostDetailReplyDialogUpdateOption.SET;
}

PostDetailReplyDialogState _loadMoreFinished(PostDetailReplyDialogState state, Action action) {
  return PostDetailReplyDialogState()
    ..replies = action.payload
    ..replyCurrentPage = state.replyCurrentPage + 1
    ..updateOption = PostDetailReplyDialogUpdateOption.ADD;
}

PostDetailReplyDialogState _deletedReply(PostDetailReplyDialogState state, Action action) {
  return PostDetailReplyDialogState()
    ..deleteIndex = action.payload
    ..updateOption = PostDetailReplyDialogUpdateOption.DELETE;
}

PostDetailReplyDialogState _dispose(PostDetailReplyDialogState state, Action action) {
  return PostDetailReplyDialogState()
    ..updateOption = PostDetailReplyDialogUpdateOption.CLEAN;
}