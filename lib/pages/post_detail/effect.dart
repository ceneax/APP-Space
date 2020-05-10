import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

import 'package:space/config.dart';
import 'package:space/network/api.dart';
import 'package:space/utils/dialog_util.dart';
import 'package:space/widgets/image_viewer.dart';

import 'action.dart';
import 'state.dart';

Effect<PostDetailState> buildEffect() {
  return combineEffects(<Object, Effect<PostDetailState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    PostDetailAction.refresh: _refresh,
    PostDetailAction.closePage: _closePage,
    PostDetailAction.loadMore: _loadMore,
    PostDetailAction.selectMenu: _selectMenu,
    PostDetailAction.sendComment: _sendComment,
    PostDetailAction.selectCommentMenu: _selectCommentMenu,
    PostDetailAction.showReply: _showReply,
    PostDetailAction.sendReply: _sendReply,
    PostDetailAction.copyToClipBoard: _copyToClipBoard,
    PostDetailAction.showImage: _showImage,
  });
}

void _init(Action action, Context<PostDetailState> ctx) {
  _refresh(action, ctx);
}

void _dispose(Action action, Context<PostDetailState> ctx) {
  ctx.state.scrollController.dispose();
}

/// 检测帖子是否存在
Future<bool> _checkPostExist(String postId) async {
  var checkRes = await Api.getInstance().checkPost(postId);
  if(checkRes is int)
    return Future.value(false);

  return Future.value(true);
}

Future<void> _refresh(Action action, Context<PostDetailState> ctx) async {
  if(!await _checkPostExist(ctx.state.post['objectId'])) {
    ctx.dispatch(PostDetailActionCreator.onNoPost());
    return;
  }

  var res = await Api.getInstance().getComments(1, ctx.state.post['objectId'], 0);
  if(res is int) {
    showToast('评论获取失败啦！！代码：$res');
    return;
  }
  if(res['result'].length <= 0) {
    showToast('这个动态好像还没有人来评论。。');
    return;
  }

  ctx.dispatch(PostDetailActionCreator.onRefreshed(res['result']));
  return;
}

void _closePage(Action action, Context<PostDetailState> ctx) {
  Navigator.pop(ctx.context);
}

Future<void> _loadMore(Action action, Context<PostDetailState> ctx) async {
  if(!await _checkPostExist(ctx.state.post['objectId'])) {
    showToast('评论获取失败啦！！');
    return;
  }

  var res = await Api.getInstance().getComments(ctx.state.currentPage + 1, ctx.state.post['objectId'], 0);
  if(res is int) {
    showToast('评论获取失败啦！！代码：$res');
    return;
  }
  if(res['result'].length <= 0) {
    showToast('没有评论啦，加载完啦~~');
    return;
  }

  ctx.dispatch(PostDetailActionCreator.onLoadMoreFinished(res['result']));
}

void _selectMenu(Action action, Context<PostDetailState> ctx) async {
  if(action.payload == PostDetailOption.DELETE) {
    var res = await Api.getInstance().delete('Post', ctx.state.post['objectId'], ctx.state.userInfo['sessionToken']);
    if(res is int) {
      showToast('删除失败了，不知道什么问题，代码：$res');
      return;
    }
    /// 判断209，账号是否过期
    Navigator.pop(ctx.context);
  }
}

void _sendComment(Action action, Context<PostDetailState> ctx) {
  if(!ctx.state.isLogin) {
    showToast('登陆才能评论哦～');
    return;
  }

  DialogUtil.showBottomSheetTextField(ctx.context, '发个评论', (String content) async {
    var res = await Api.getInstance().sendComment(content, ctx.state.post['objectId'], ctx.state.userInfo['objectId'], ctx.state.userInfo['sessionToken']);
    if(res is int) {
      /// 判断结果209
      showToast('评论失败，代码：$res');
      return;
    }

    showToast('评论成功了哦～');
    _refresh(action, ctx);
  });
}

void _selectCommentMenu(Action action, Context<PostDetailState> ctx) async {
  var data = action.payload;

  if(data['value'] == PostDetailCommentOption.DELETE) {
    var res = await Api.getInstance().delete('Comment', ctx.state.comments[data['index']]['objectId'], ctx.state.userInfo['sessionToken']);
    if(res is int) {
      /// 判断209，账号是否过期
      showToast('删除失败了，不知道什么问题，代码：$res');
      return;
    }

    ctx.dispatch(PostDetailActionCreator.onCommentDeteled(data['index']));
  }
}

void _showReply(Action action, Context<PostDetailState> ctx) {
  ctx.dispatch(PostDetailActionCreator.onSetCommentId(action.payload));
  showModalBottomSheet(
      context: ctx.context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20))
      ),
      builder: (context) => ctx.buildComponent('reply_dialog')
  );
}

void _sendReply(Action action, Context<PostDetailState> ctx) {
  if(ctx.state.isLogin) {
    DialogUtil.showBottomSheetTextField(ctx.context, '回复“${ctx.state.comments[action.payload]['author']['nickname']}”', (String content) async {
      var res = await Api.getInstance().sendReply(content, ctx.state.comments[action.payload]['objectId'], ctx.state.userInfo['objectId'], ctx.state.userInfo['sessionToken']);
      if(res is int) {
        /// 判断209
        showToast('回复失败，代码：$res');
        return;
      }

      showToast('回复成功了哦～');
      _refresh(action, ctx);
    });
  }
}

void _copyToClipBoard(Action action, Context<PostDetailState> ctx) {
  Clipboard.setData(ClipboardData(text: action.payload));
  showToast('内容已经复制到粘贴板了～');
}

void _showImage(Action action, Context<PostDetailState> ctx) {
  Navigator.push(ctx.context, MaterialPageRoute(
      builder: (context) => ImageViewer(images: action.payload['data'], index: action.payload['index'], header: {'Referer': Config.UPY_STORAGE_REFERER})
  ));
}