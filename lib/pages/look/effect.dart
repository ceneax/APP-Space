import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/pages/video_player/action.dart';
import '../../network/api.dart';

import 'action.dart';
import 'state.dart';

Effect<LookState> buildEffect() {
  return combineEffects(<Object, Effect<LookState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    LookAction.refresh: _refresh,
    LookAction.loadMore: _loadMore,
    LookAction.goLive: _goLive,
    LookAction.goVideo: _goVideo,
  });
}

void _init(Action action, Context<LookState> ctx) {
  _refresh(action, ctx);
}

void _dispose(Action action, Context<LookState> ctx) {
  ctx.state.scrollController.dispose();
}

Future<void> _refresh(Action action, Context<LookState> ctx) async {
  var res = await Api.getInstance().getVideo(1);
  if(res is int) {
    showToast('视频获取失败啦！！代码：$res');
    return;
  }

  var videos = res['result'];
  if(videos.length > 0) {
    ctx.dispatch(LookActionCreator.onRefreshed(videos));
  } else {
    showToast('视频获取失败啦！！');
  }

  return;
}

Future<void> _loadMore(Action action, Context<LookState> ctx) async {
  var res = await Api.getInstance().getVideo(ctx.state.currentPage + 1);
  if(res is int) {
    showToast('视频获取失败啦！！代码：$res');
  } else {
    var videos = res['result'];
    if(videos.length > 0) {
      ctx.dispatch(LookActionCreator.onLoadMoreFinished(videos));
    } else {
      showToast('没有更多啦！！');
    }
  }
}

void _goLive(Action action, Context<LookState> ctx) async {
  var res = await Api.getInstance().getLive();
  if(res is int) {
    showToast('直播信息获取失败啦！！代码：$res');
    return;
  }

  if(res['status']) {
    Navigator.pushNamed(ctx.context, 'video_palyer_page', arguments: {
      'url': res['url'],
      'type': VideoType.LIVE,
      'referer': res['referer']
    });
  } else {
    showToast('暂时没有直播可以看。。');
  }
}

void _goVideo(Action action, Context<LookState> ctx) {
  Navigator.pushNamed(ctx.context, 'video_palyer_page', arguments: {
    'url': '${action.payload['aid']}-${action.payload['cid']}',
    'type': VideoType.BILIBILI,
    'referer': 'https://www.bilibili.com/video/${action.payload['bvid']}'
  });
}