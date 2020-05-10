import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VastState state, Dispatch dispatch, ViewService viewService) {
  /// 返回header
  Widget _header() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        child: Container(
          width: WidgetUtil.getScreenWidth(),
          height: 816 * WidgetUtil.getScreenWidth() / 1688,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/vast_banner.png'),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        onTap: () => dispatch(VastActionCreator.onAction()),
      ),
    );
  }

  return CustomScrollView(
    slivers: <Widget>[
      _header(),
    ],
  );
}
