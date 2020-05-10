import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api2.dart';

import 'action.dart';
import 'state.dart';

Effect<PolularScienceDetailState> buildEffect() {
  return combineEffects(<Object, Effect<PolularScienceDetailState>>{
    Lifecycle.initState: _init,
    PolularScienceDetailAction.close: _close,
  });
}

void _init(Action action, Context<PolularScienceDetailState> ctx) async {
  var res = await Api2.getInstance().getPolularScienceDetail(ctx.state.id);
  if(res is int) {
    showToast('科普详情获取失败啦！！代码：$res');
    return;
  }

  ctx.dispatch(PolularScienceDetailActionCreator.onSetData(res['content']));
}

void _close(Action action, Context<PolularScienceDetailState> ctx) {
  Navigator.pop(ctx.context);
}