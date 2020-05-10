import 'package:badges/badges.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:space/widgets/keep_alive_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  /// 用于返回可缓存（保持状态）的Widget
  Widget _buildAlivePage(Widget page) => KeepAliveWidget(page);

  return Scaffold(
    body: PageView(
      children: state.pages.map(_buildAlivePage).toList(),
      controller: state.pageController,
      onPageChanged: (index) => dispatch(MainActionCreator.onTabChanged(index)),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.wifi_tethering),
            title: Text('发射')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.language),
            title: Text('小宇宙')
        ),
        BottomNavigationBarItem(
            icon: Badge( /// 显示底部tabBar未读消息红点
              badgeContent: Text('${state.noticeNum}', style: TextStyle(color: Colors.white, fontSize: 10)),
              child: Icon(Icons.account_circle),
              elevation: 0,
              showBadge: state.noticeNum > 0,
            ),
            title: Text('我')
        ),
      ],
      currentIndex: state.selectedIndex,
      selectedItemColor: state.themeData.primaryColor,
      selectedFontSize: 12,
      onTap: (index) {
        state.pageController.jumpToPage(index);
      },
    ),
  );
}
