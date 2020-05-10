import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class PostDetailState implements Cloneable<PostDetailState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  var post;
  bool existPost;

  List<dynamic> comments;
  int currentPage;

  ScrollController scrollController;

  /// 这些是ReplyDialogComponent用到的属性
  String commentId;
  List<dynamic> replies;
  int replyCurrentPage;

  @override
  PostDetailState clone() {
    return PostDetailState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..post = post
      ..existPost = existPost
      ..comments = comments
      ..currentPage = currentPage
      ..scrollController = scrollController
      ..commentId = commentId
      ..replies = replies
      ..replyCurrentPage = replyCurrentPage;
  }

}

PostDetailState initState(Map<String, dynamic> args) {
  return PostDetailState()
    ..post = args
    ..existPost = true
    ..comments = []
    ..currentPage = 1
    ..scrollController = ScrollController()
    ..commentId = ''
    ..replies = []
    ..replyCurrentPage = 1;
}
