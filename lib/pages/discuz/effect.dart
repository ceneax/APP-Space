import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/config.dart';
import 'package:space/network/api.dart';
import 'package:space/widgets/image_viewer.dart';

import 'action.dart';
import 'state.dart';

Effect<DiscuzState> buildEffect() {
  return combineEffects(<Object, Effect<DiscuzState>>{
    Lifecycle.initState: _init,
    DiscuzAction.refresh: _refresh,
    DiscuzAction.loadMore: _loadMore,
    DiscuzAction.newPostPage: _newPostPage,
    DiscuzAction.postDetailPage: _postDetailPage,
    DiscuzAction.showImage: _showImage,
  });
}

void _init(Action action, Context<DiscuzState> ctx) {
  _refresh(action, ctx);
}

Future<void> _refresh(Action action, Context<DiscuzState> ctx) async {
  var postsRes = await Api.getInstance().getPosts(1);
  if(postsRes is int) {
    showToast('动态获取失败啦！！代码：$postsRes');
    return;
  }

  var posts = postsRes['result'];
  if(posts.length > 0) {
    ctx.dispatch(DiscuzActionCreator.onReset(posts));
  } else {
    showToast('动态获取失败啦！！');
  }

  return;
}

Future<void> _loadMore(Action action, Context<DiscuzState> ctx) async {
  var postsRes = await Api.getInstance().getPosts(ctx.state.currentPage + 1);
  if(postsRes is int) {
    showToast('动态获取失败啦！！代码：$postsRes');
  } else {
    var posts = postsRes['result'];
    if(posts.length > 0) {
      ctx.dispatch(DiscuzActionCreator.onLoadMoreFinished(posts));
    } else {
      showToast('已经没有更多内容啦！！');
    }
  }
}

void _newPostPage(Action action, Context<DiscuzState> ctx) async {
  if(!ctx.state.isLogin) {
    showToast('需要先登录才能发动态！！！');
    return;
  }

  final result = await Navigator.pushNamed(ctx.context, 'new_post_page');
  if(result == 'refresh')
    _refresh(action, ctx);
}

void _postDetailPage(Action action, Context<DiscuzState> ctx) {
  Navigator.pushNamed(ctx.context, 'post_detail_page', arguments: ctx.state.posts[action.payload]);
}

void _showImage(Action action, Context<DiscuzState> ctx) {
  Navigator.push(ctx.context, MaterialPageRoute(
    builder: (context) => ImageViewer(images: action.payload['data'], index: action.payload['index'], header: {'Referer': Config.UPY_STORAGE_REFERER})
  ));
}