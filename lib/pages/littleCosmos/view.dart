import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/widgets/app_bar_corner.dart';
import 'package:space/widgets/keep_alive_widget.dart';
import 'package:space/widgets/my_underline_tab_indicator.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LittleCosmosState state, Dispatch dispatch, ViewService viewService) {
  Widget _appBar() {
    return AppBar(
      backgroundColor: state.themeData.primaryColor,
      elevation: 0,
      bottom: PreferredSize(
        child: AppBarCorner(color: state.themeData.canvasColor),
        preferredSize: Size.fromHeight(20), /// 这里的高度和上面定义的方法中_headerCorner里面的高度一致
      ),
      title: DefaultTabController(
        length: state.tabs.length,
        child: Container(
          child: TabBar(
            isScrollable: true,
            controller: state.tabController,
            indicator: MyUnderlineTabIndicator(
                insets: EdgeInsets.fromLTRB(10, 5, 10, 5),
                borderSide: BorderSide(
                    width: 6,
                    color: state.themeData.textTheme.display4.color
                )
            ),
            labelColor: state.themeData.textTheme.display4.color,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15
            ),
            tabs: state.tabs.map((tab) => Tab(text: tab)).toList(),
            onTap: (index) => dispatch(LittleCosmosActionCreator.onTabChanged(index)),
          ),
        ),
      ),
    );
  }

  /// 用于返回可缓存（保持状态）的Widget
  Widget _buildAlivePage(Widget page) => KeepAliveWidget(page);

  /// 返回body
  Widget _body() {
    return PageView(
      children: state.pages.map(_buildAlivePage).toList(),
      controller: state.pageController,
      onPageChanged: (index) => dispatch(LittleCosmosActionCreator.onPageChanged(index)),
    );
  }

  return Scaffold(
    appBar: _appBar(),
    body: _body(),
  );

}