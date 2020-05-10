import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/utils/widget_util.dart';
import 'package:space/widgets/app_bar_corner.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MeState state, Dispatch dispatch, ViewService viewService) {
  /// 返回appBar
  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: state.themeData.primaryColor,
      title: Text('我自己', style: TextStyle(color: state.themeData.textTheme.display4.color)),
      expandedHeight: WidgetUtil.getStatusBarHeight() + kToolbarHeight + 120,
      floating: false,
      pinned: true,
      centerTitle: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            child: Padding( /// 主要部分
              padding: EdgeInsets.fromLTRB(20, WidgetUtil.getStatusBarHeight() + kToolbarHeight, 20, 20),
              child: Row( /// 将子布局分成两行，左边是头像，右边是id和信息
                children: <Widget>[
                  Container( /// 头像
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(state.isLogin ? state.userInfo['avatar'] : 'http://img.space.lxiian.cn/avatar/avatar.png', headers: {'Referer': Config.UPY_STORAGE_REFERER})
                        )
                    ),
                  ),
                  Column( /// id和信息
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text( /// id
                          state.isLogin ? state.userInfo['nickname'] : '点这里去登陆',
                          style: TextStyle(
                              fontSize: 16 ,
                              color: state.themeData.textTheme.display4.color
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container( /// 性别
                            padding: EdgeInsets.fromLTRB(6, 1, 6, 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                color: state.themeData.canvasColor
                            ),
                            child: Text(
                              state.isLogin ? state.userInfo['sex'] == '0' ? '女♀' : '男♂' : '男♂ 女♀',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: state.themeData.textTheme.display1.color
                              ),
                            ),
                          ),
                          Offstage(
                            offstage: !state.isLogin,
                            child: Container( /// username
                              padding: EdgeInsets.fromLTRB(6, 1, 6, 1),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: state.themeData.canvasColor
                              ),
                              child: Text(
                                state.isLogin ? state.userInfo['username'] : '',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: state.themeData.textTheme.display1.color
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () => dispatch(MeActionCreator.onHeadClick()),
          ),
        ),
      ),
      bottom: AppBarCorner(color: state.themeData.canvasColor),
    );
  }

  /// 返回listHeader
  Widget _listHeader(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12,
            color: state.themeData.textTheme.display1.color
        ),
      ),
    );
  }

  /// 返回listItem
  Widget _listItem(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 15)),
      trailing: Icon(Icons.navigate_next),
      onTap: () => dispatch(MeActionCreator.onMenuClick(title)),
    );
  }

  /// 返回body
  Widget _body() {
    /// 未登陆的情况下返回此布局
    if(!state.isLogin) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Text('还没有登陆呢~'),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
            if(state.menu[index] == '消息通知' || state.menu[index] == '操作') {
              return _listHeader(state.menu[index]);
            } else {
              return _listItem(state.menu[index]);
            }
          },
      childCount: state.menu.length
      ),
    );
  }

  /// 返回footer
  Widget _footer() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          '当前版本：${state.versionName}',
          style: TextStyle(
              fontSize: 12,
              color: state.themeData.textTheme.display1.color
          ),
        ),
      ),
    );
  }

  return CustomScrollView(
    slivers: <Widget>[
      _appBar(),
      _body(),
      _footer()
    ],
    physics: AlwaysScrollableScrollPhysics(),
  );
}
