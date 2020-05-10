import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api2.dart';

import 'action.dart';
import 'state.dart';

Effect<PolularScienceState> buildEffect() {
  return combineEffects(<Object, Effect<PolularScienceState>>{
    Lifecycle.dispose: _dispose,
    PolularScienceAction.itemClick: _itemClick,
    PolularScienceAction.refresh: _refresh,
    PolularScienceAction.loadMore: _loadMore,
    PolularScienceAction.listSelect: _listSelect,
  });
}

void _dispose(Action action, Context<PolularScienceState> ctx) {
  ctx.state.scrollController.dispose();
}

void _itemClick(Action action, Context<PolularScienceState> ctx) {
  ctx.dispatch(PolularScienceActionCreator.onIndexChanged(action.payload));
  _refresh(action, ctx);
}

Future<void> _refresh(Action action, Context<PolularScienceState> ctx) async {
  var res = await Api2.getInstance().getPolularScience(1, ctx.state.currentIndex);
  if(res is int) {
    showToast('科普数据获取失败啦！！代码：$res');
    return;
  }

  var polularSciences = res['result'];
  if(polularSciences.length > 0) {
    ctx.dispatch(PolularScienceActionCreator.onRefreshed(polularSciences));
  } else {
    showToast('科普数据获取失败啦！！');
  }

  return;
}

Future<void> _loadMore(Action action, Context<PolularScienceState> ctx) async {
  var res = await Api2.getInstance().getPolularScience(ctx.state.currentPage + 1, ctx.state.currentIndex);
  if(res is int) {
    showToast('科普数据获取失败啦！！代码：$res');
  } else {
    var polularSciences = res['result'];
    if(polularSciences.length > 0) {
      ctx.dispatch(PolularScienceActionCreator.onLoadMoreFinished(polularSciences));
    } else {
      showToast('已经没有更多内容啦！！');
    }
  }
}

void _listSelect(Action action, Context<PolularScienceState> ctx) {
  Navigator.pushNamed(ctx.context, 'polular_science_detail_page', arguments: {
    'id': ctx.state.polularSciences[action.payload]['objectId'],
    'title': ctx.state.polularSciences[action.payload]['title']
  });
}