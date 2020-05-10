import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api2.dart';
import 'package:space/routes/routes.dart';

import 'action.dart';
import 'state.dart';

Effect<LaunchState> buildEffect() {
  return combineEffects(<Object, Effect<LaunchState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    LaunchAction.refresh: _refresh,
    LaunchAction.loadMore: _loadMore,
    LaunchAction.itemClick: _itemClick,
    LaunchAction.jumpToTop: _jumpToTop,
  });
}

void _initState(Action action, Context<LaunchState> ctx) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ctx.dispatch(LaunchActionCreator.onInit());
    _refresh(action, ctx); /// 初始化的时候从服务器加载数据
  });

  if(ctx.state.timer == null) {
    ctx.state.timer = Timer.periodic(Duration(seconds: 1), (_) {
      int launchUTCTimestamp = DateTime.parse(ctx.state.upcomingOne['launch_net']).millisecondsSinceEpoch;
      int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

      int allSecond = ((launchUTCTimestamp - nowTimestamp) / 1000).floor();
      int day, hour, minute, second;

      if(allSecond <= 0) {
        day = 0;
        hour = 0;
        minute = 0;
        second = 0;
      } else {
        day = (allSecond / 3600 / 24).floor();
        hour = (allSecond / 3600 % 24).floor();
        minute = (allSecond / 60 % 60).floor();
        second = (allSecond % 60).floor();
      }

      ctx.dispatch(LaunchActionCreator.onUpdateCounter('$day天 - $hour时 - $minute分 - $second秒'));
    });
  }
}

void _dispose(Action action, Context<LaunchState> ctx) {
  ctx.state.scrollController.dispose();
  ctx.state.timer.cancel();
}

/// 返回Future类型是因为这个方法挂载到了view层的onRefresh接口，这里return后，refreshIndicator自动消失
Future<void> _refresh(Action action, Context<LaunchState> ctx) async {
  var upcomingRes = await Api2.getInstance().getUpcoming();
  var pastRes = await Api2.getInstance().getPast(1); /// 因为是刷新操作，参数page写死为1

  /// 定义了临时list，用于传递数据给reducer显示到ui；第0个元素是upcoming，第1个是past
  List<dynamic> tmpData = [];

  if(upcomingRes is int && pastRes is int) {
    showToast('发射数据获取失败啦！！代码：$upcomingRes');
    return;
  }

  if(upcomingRes is int) {
    showToast('发射预告数据获取失败啦！！代码：$upcomingRes');
    tmpData.add(null);
  } else {
    var upcoming = upcomingRes['result'];
    if(upcoming.length > 0) {
      tmpData.add(upcoming);
    } else {
      showToast('发射预告数据获取失败啦！！');
      tmpData.add(null);
    }
  }

  if(pastRes is int) {
    showToast('历史发射数据获取失败啦！！代码：$pastRes');
    tmpData.add(null);
  } else {
    var past = pastRes['result'];
    if(past.length > 0) {
      tmpData.add(past);
    } else {
      showToast('历史发射数据获取失败啦！！');
      tmpData.add(null);
    }
  }

  /// 传递数据给reducer
  ctx.dispatch(LaunchActionCreator.onResetData(tmpData));

  return;
}

void _loadMore(Action action, Context<LaunchState> ctx) async {
  var pastRes = await Api2.getInstance().getPast(ctx.state.currentPage + 1);

  if(pastRes is int) {
    showToast('加载历史发射数据失败啦！！代码：$pastRes');
  } else {
    var past = pastRes['result'];
    if(past.length > 0) {
      ctx.dispatch(LaunchActionCreator.onLoadMoreFinished(past));
    } else {
      showToast('已经没有更多内容啦！！');
    }
  }
}

void _itemClick(Action action, Context<LaunchState> ctx) {
  int index = action.payload;
  var data = {};
  LaunchStatus status;

  if(index == -1) {
    data = ctx.state.upcomingOne;
    status = LaunchStatus.UPCOMING;
  } else {
    data = ctx.state.past[index];
    status = LaunchStatus.PAST;
  }

  Navigator.pushNamed(ctx.context, 'launch_detail_page', arguments: {
    'type': status,
    'data': data
  });
}

void _jumpToTop(Action action, Context<LaunchState> ctx) {
  ctx.state.scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
}