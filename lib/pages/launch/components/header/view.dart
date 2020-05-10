import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/launch/action.dart';
import 'package:space/widgets/sliver_persistent_header_delegate.dart';
import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LaunchHeaderState state, Dispatch dispatch, ViewService viewService) {
  /// header第三行widget的模板
  Widget _headerThreeTemp(String content) {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: state.themeData.canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Text(
        content,
        style: TextStyle(
            color: state.themeData.textTheme.display1.color,
            fontSize: 12
        ),
      ),
    );
  }

  /// 构建header布局
  return SliverPersistentHeader(
    pinned: true,
    floating: true,
    delegate: MySliverPersistentHeaderDelegate(
        minHeight: state.headerMinHeight,
        maxHeight: state.headerMaxHeight,
        child: GestureDetector(
          onTap: () => dispatch(LaunchActionCreator.onItemClick(-1)), /// 这里使用的是page的actionCreator，返回-1代表是header点击
          child: Container(
            color: state.themeData.primaryColor,
            padding: EdgeInsets.only(top: WidgetUtil.getStatusBarHeight()),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(state.headerWidgetMargin),
                  child: Center(
                    child: Text(
                      '发射倒计时',
                      key: state.key1,
                      style: TextStyle(
                          color: state.themeData.textTheme.display4.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: state.headerWidgetMargin),
                  child: Center(
                    child: Text(
                      state.countText,
                      key: state.key2,
                      style: TextStyle(
                        color: state.themeData.textTheme.display4.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  key: state.key3,
                  margin: EdgeInsets.only(bottom: state.headerWidgetMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _headerThreeTemp(state.upcomingOne['agency']['name']),
                      _headerThreeTemp(state.upcomingOne['rocket']['name']),
                      _headerThreeTemp(state.upcomingOne['launch_name'])
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    ),
  );
}
