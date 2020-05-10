import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/post_detail/state.dart';

import 'action.dart';

class PostDetailReplyDialogState {

  ThemeData themeData;
  dynamic userInfo;
  bool isLogin;
  String commentId;
  List<dynamic> replies;
  int replyCurrentPage;

  /// 私有属性，不参与get和set，只是在reducer中传递一个flag，用于在set中判断操作类型
  PostDetailReplyDialogUpdateOption updateOption;
  int deleteIndex;

}

class PostDetailReplyDialogConnector extends ConnOp<PostDetailState, PostDetailReplyDialogState> {

  @override
  PostDetailReplyDialogState get(PostDetailState state) {
    return PostDetailReplyDialogState()
      ..themeData = state.themeData
      ..userInfo = state.userInfo
      ..isLogin = state.isLogin
      ..commentId = state.commentId
      ..replyCurrentPage = state.replyCurrentPage
      ..replies = state.replies;
  }

  @override
  void set(PostDetailState state, PostDetailReplyDialogState subState) {
    if(subState.updateOption == PostDetailReplyDialogUpdateOption.SET) {
      state.replies = subState.replies;
      state.replyCurrentPage = 1;
    } else if(subState.updateOption == PostDetailReplyDialogUpdateOption.ADD) {
      state.replies.addAll(subState.replies);
      state.replyCurrentPage = subState.replyCurrentPage;
    } else if(subState.updateOption == PostDetailReplyDialogUpdateOption.DELETE) {
      state.replies.removeAt(subState.deleteIndex);
    } else {
      state.replies.clear();
    }
  }

}