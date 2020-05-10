import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:space/pages/video_player/action.dart';
import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Effect<LaunchDetailState> buildEffect() {
  return combineEffects(<Object, Effect<LaunchDetailState>>{
    Lifecycle.initState: _init,
    LaunchDetailAction.closePage: _closePage,
    LaunchDetailAction.showVideo: _showVideo,
  });
}

void _init(Action action, Context<LaunchDetailState> ctx) {
  ctx.dispatch(LaunchDetailActionCreator.onInited(WidgetUtil.getScreenWidth() - WidgetUtil.getStatusBarHeight()));
}

void _closePage(Action action, Context<LaunchDetailState> ctx) {
  Navigator.pop(ctx.context);
}

void _showVideo(Action action, Context<LaunchDetailState> ctx) async {
  var tmpList = ctx.state.data['video'].toString().split('-');

  Navigator.pushNamed(ctx.context, 'video_palyer_page', arguments: {
    'url': '${tmpList[1]}-${tmpList[2]}',
    'type': VideoType.BILIBILI,
    'referer': 'https://www.bilibili.com/video/${tmpList[0]}'
  });
}