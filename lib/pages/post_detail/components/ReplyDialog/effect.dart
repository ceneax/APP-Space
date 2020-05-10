import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api.dart';
import 'package:space/utils/dialog_util.dart';

import 'action.dart';
import 'state.dart';

Effect<PostDetailReplyDialogState> buildEffect() {
  return combineEffects(<Object, Effect<PostDetailReplyDialogState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    PostDetailReplyDialogAction.loadMore: _loadMore,
    PostDetailReplyDialogAction.deleteReply: _deleteReply,
    PostDetailReplyDialogAction.sendReply: _sendReply,
    PostDetailReplyDialogAction.copyToClipBoard: _copyToClipBoard,
  });
}

void _init(Action action, Context<PostDetailReplyDialogState> ctx) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _getReply(ctx);
  });
}

void _dispose(Action action, Context<PostDetailReplyDialogState> ctx) {
  ctx.dispatch(PostDetailReplyDialogActionCreator.onDispose());
}

void _getReply(Context<PostDetailReplyDialogState> ctx) async {
  var res = await Api.getInstance().getReplies(1, ctx.state.commentId);
  if(res is int) {
    showToast('回复详情获取失败啦！！代码：$res');
    return;
  }
  if(res['result'].length <= 0) {
    showToast('回复详情获取失败啦！！');
    return;
  }

  ctx.dispatch(PostDetailReplyDialogActionCreator.onSetReplies(res['result']));
}

Future<void> _loadMore(Action action, Context<PostDetailReplyDialogState> ctx) async {
  var res = await Api.getInstance().getReplies(ctx.state.replyCurrentPage + 1, ctx.state.commentId);
  if(res is int) {
    showToast('回复详情获取失败啦！！代码：$res');
    return;
  }
  if(res['result'].length <= 0) {
    showToast('已经没有更多回复啦！！');
    return;
  }

  ctx.dispatch(PostDetailReplyDialogActionCreator.onLoadMoreFinished(res['result']));
}

void _deleteReply(Action action, Context<PostDetailReplyDialogState> ctx) async {
  var data = action.payload;

  if(data['value'] == PostDetailReplyDialogOption.DELETE) {
    var res = await Api.getInstance().delete('Reply', ctx.state.replies[data['index']]['objectId'], ctx.state.userInfo['sessionToken']);
    if(res is int) {
      /// 判断209
      showToast('回复删除失败啦！！代码：$res');
      return;
    }

    ctx.dispatch(PostDetailReplyDialogActionCreator.onDeletedReply(data['index']));
  }
}

void _sendReply(Action action, Context<PostDetailReplyDialogState> ctx) async {
  if(ctx.state.isLogin) {
    DialogUtil.showBottomSheetTextField(ctx.context, '回复“${ctx.state.replies[action.payload]['author']['nickname']}”', (String content) async {
      var res = await Api.getInstance().sendReply(content, ctx.state.commentId, ctx.state.userInfo['objectId'], ctx.state.userInfo['sessionToken'], reply: ctx.state.replies[action.payload]['objectId']);
      if(res is int) {
        /// 判断209
        showToast('回复失败，代码：$res');
        return;
      }

      showToast('回复成功了哦～');
      _getReply(ctx);
    });
  }
}

void _copyToClipBoard(Action action, Context<PostDetailReplyDialogState> ctx) {
  Clipboard.setData(ClipboardData(text: action.payload));
  showToast('内容已经复制到粘贴板了～');
}