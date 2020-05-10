import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../utils/widget_util.dart';
import '../../widgets/lx_sliver_list_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LookState state, Dispatch dispatch, ViewService viewService) {
  /// 返回header
  Widget _header() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        child: Container(
          width: WidgetUtil.getScreenWidth(),
          height: 3 * WidgetUtil.getScreenWidth() / 8,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/littlecosmos_look_live_banner.png'),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        onTap: () => dispatch(LookActionCreator.onGoLive()),
      ),
    );
  }

  /// 构建gridViewItem
  Widget _gridItem(int index) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: state.themeData.cardColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(state.videos[index]['image'])
                    )
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5),
              child: Text(
                state.videos[index]['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => dispatch(LookActionCreator.onGoVideo(state.videos[index])),
    );
  }

  /// 返回gridView
  Widget _gridView() {
    return LXSliverListView.gridView(
      builder: (context, index) => _gridItem(index),
      itemCount: state.videos.length,
      controller: state.scrollController,
      padding: EdgeInsets.all(10),
      loadMore: () async {
        await dispatch(LookActionCreator.onLoadMore());
      },
    );
  }

  return RefreshIndicator(
    child: CustomScrollView(
      slivers: <Widget>[
        _header(),
        _gridView(),
      ],
      controller: state.scrollController,
    ),
    onRefresh: () async {
      return await dispatch(LookActionCreator.onRefresh());
    },
  );
}
