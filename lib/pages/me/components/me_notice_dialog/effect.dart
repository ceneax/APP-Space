import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api.dart';

import 'action.dart';
import 'state.dart';

Effect<MeNoticeDialogState> buildEffect() {
  return combineEffects(<Object, Effect<MeNoticeDialogState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    MeNoticeDialogAction.loadMore: _loadMore,
    MeNoticeDialogAction.jumpToPostDetail: _jumpToPostDetail,
  });
}

void _init(Action action, Context<MeNoticeDialogState> ctx) {
  _getNotice(ctx);
}

void _getNotice(Context<MeNoticeDialogState> ctx) async {
  var res = await Api.getInstance().getNotifications(ctx.state.userInfo['sessionToken'], ctx.state.userInfo['objectId'], 1);
  if(res is int) {
    showToast('获取失败啦～代码：$res'); /// 应该需要判断session是否过期
    return;
  }
  if(res['result'].length <= 0) {
    showToast('你没有消息可以查看呢~~');
    return;
  }

  ctx.dispatch(MeNoticeDialogActionCreator.onSetNotice(res['result']));

  /// 将未读消息设置为已读
  Api.getInstance().changeNotification(ctx.state.userInfo['sessionToken'], ctx.state.userInfo['objectId']);
}

Future<void> _loadMore(Action action, Context<MeNoticeDialogState> ctx) async {
  var res = await Api.getInstance().getNotifications(ctx.state.userInfo['sessionToken'], ctx.state.userInfo['objectId'], ctx.state.noticeCurrentPage + 1);
  if(res is int) {
    showToast('获取失败啦～代码：$res'); /// 应该需要判断session是否过期
    return;
  }
  if(res['result'].length <= 0) {
    showToast('没有更多消息了，就这些~~');
    return;
  }

  ctx.dispatch(MeNoticeDialogActionCreator.onLoadMoreFinished(res['result']));
}

void _dispose(Action action, Context<MeNoticeDialogState> ctx) {
  ctx.dispatch(MeNoticeDialogActionCreator.onDispose());
}

void _jumpToPostDetail(Action action, Context<MeNoticeDialogState> ctx) {
  var post = {};

  if(ctx.state.notice[action.payload]['type'] == 1)
    post = ctx.state.notice[action.payload]['comment']['post'];
  else
    post = ctx.state.notice[action.payload]['reply']['comment']['post'];

  Navigator.pushNamed(ctx.context, 'post_detail_page', arguments: post);
}