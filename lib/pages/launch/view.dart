import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/widgets/lx_sliver_list_view.dart';
import 'package:space/widgets/sliver_persistent_header_delegate.dart';
import '../../config.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LaunchState state, Dispatch dispatch, ViewService viewService) {
  /// 构建header和gridView之间的圆角
  Widget _headerCorner() {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: MySliverPersistentHeaderDelegate(
          minHeight: 20,
          maxHeight: 20,
          child: Container(
            color: state.themeData.primaryColor,
            foregroundDecoration: BoxDecoration(
                color: state.themeData.canvasColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
          )
      ),
    );
  }

  /// 返回处理后的发射结果
  String _getLaunched(int status) {
    String res;

    switch(status) {
      case 0:
        res = '成功';
        break;
      case 1:
        res = '失败';
        break;
      case 2:
        res = '部分成功';
        break;
    }

    return res;
  }

  /// 获取图片
  ImageProvider _getImageByLaunch(String url) {
    if(url == null || url == '') {
      return AssetImage('images/rocket_default.png');
    }

    return NetworkImage(url, headers: {'Referer': Config.UPY_STORAGE_REFERER});
  }

  /// 返回gridView的Item
  Widget _gridViewItem(int index) {
    return GestureDetector(
      child: Hero(
        tag: 'LaunchImage${state.past[index]['objectId']}',
        child: Container(
//        height: listItemWidth,
//        width: listItemWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: _getImageByLaunch(state.past[index]['rocket']['img']),
                fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromARGB(80, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              '发射结果：${_getLaunched(state.past[index]['launch_status'])}\n'
                  '载荷：${state.past[index]['launch_name']}\n'
                  '火箭：${state.past[index]['rocket']['name']}\n'
                  '发射机构：${state.past[index]['agency']['name']}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11
              ),
            ),
          ),
        ),
      ),
      onTap: () => dispatch(LaunchActionCreator.onItemClick(index)),
    );
  }

  /// 拼装各个Widget和component
  return Scaffold(
    body: RefreshIndicator(
      child: CustomScrollView(
        slivers: <Widget>[
          viewService.buildComponent('header'),
          /// header和gridview之间的圆角
          _headerCorner(),
          /// sliverGridView
          LXSliverListView.gridView(
            builder: (context, index) => _gridViewItem(index),
            itemCount: state.past.length,
            controller: state.scrollController,
            padding: EdgeInsets.all(10),
            loadMore: () async {
              await dispatch(LaunchActionCreator.onLoadMore());
            },
          )
        ],
        controller: state.scrollController,
        physics: AlwaysScrollableScrollPhysics(),
      ),
      onRefresh: () => dispatch(LaunchActionCreator.onRefresh()),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: state.themeData.primaryColor,
      heroTag: 'LaunchTag',
      child: Icon(Icons.arrow_upward),
      onPressed: () => dispatch(LaunchActionCreator.onJumpToTop()),
    ),
  );
}