import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/me/state.dart';

import 'action.dart';

class MeNoticeDialogState {

  ThemeData themeData;
  dynamic userInfo;
  bool isLogin;
  List<dynamic> notice;
  int noticeCurrentPage;

  /// 私有属性，判断操作类型，不参与get和set
  MeNoticeDialogUpdateType updateType;

}

class MeNoticeDialogConnector extends ConnOp<MeState, MeNoticeDialogState> {

  @override
  MeNoticeDialogState get(MeState state) {
    return MeNoticeDialogState()
      ..themeData = state.themeData
      ..userInfo = state.userInfo
      ..isLogin = state.isLogin
      ..notice = state.notice
      ..noticeCurrentPage = state.noticeCurrentPage;
  }

  @override
  void set(MeState state, MeNoticeDialogState subState) {
    if(subState.updateType == MeNoticeDialogUpdateType.SET) {
      state.notice = subState.notice;
      state.noticeCurrentPage = 1;
    } else if(subState.updateType == MeNoticeDialogUpdateType.ADD) {
      state.notice.addAll(subState.notice);
      state.noticeCurrentPage = subState.noticeCurrentPage;
    } else {
      state.notice.clear();
    }
  }

}