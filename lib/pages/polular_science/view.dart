import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/widgets/circle_selector.dart';
import 'package:space/widgets/lx_sliver_list_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PolularScienceState state, Dispatch dispatch, ViewService viewService) {
  /// 构建header
  Widget _header() {
    return SliverToBoxAdapter(
      child: CircleSelector(
        items: state.circleSelectorItem,
        itemData: state.circleSelectorItemData,
        largeCircleBackColor: state.themeData.primaryColor,
        largeCircleTitleColor: state.themeData.textTheme.display4.color,
        largeCircleDescColor: state.themeData.textTheme.display4.color,
        smallCircleBackColor: state.themeData.primaryColor,
        smallCircleIconColor: state.themeData.textTheme.display4.color,
        itemClick: (index) => dispatch(PolularScienceActionCreator.onItemClick(index)),
      ),
    );
  }

  /// 构建listView
  Widget _listView() {
    return LXSliverListView.listView(
        builder: (context, index) {
          return ListTile(
            title: Text('${state.polularSciences[index]['title']}', style: TextStyle(fontSize: 15)),
            leading: Icon(state.circleSelectorItem[state.currentIndex]),
            onTap: () => dispatch(PolularScienceActionCreator.onListSelect(index)),
          );
        },
        itemCount: state.polularSciences.length,
        controller: state.scrollController,
        loadMore: () async {
          await dispatch(PolularScienceActionCreator.onLoadMore());
        },
    );
  }

  return RefreshIndicator(
    child: CustomScrollView(
      slivers: <Widget>[
        _header(),
        _listView(),
      ],
      controller: state.scrollController,
      physics: AlwaysScrollableScrollPhysics(),
    ),
    onRefresh: () async {
      return await dispatch(PolularScienceActionCreator.onRefresh());
    },
  );
}
