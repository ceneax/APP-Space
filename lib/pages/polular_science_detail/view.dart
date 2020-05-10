import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:space/widgets/app_bar_corner.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PolularScienceDetailState state, Dispatch dispatch, ViewService viewService) {
  /// appBar
  Widget _appBar() {
    return AppBar(
      backgroundColor: state.themeData.primaryColor,
      title: Text(state.title, style: TextStyle(color: state.themeData.textTheme.display4.color)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: state.themeData.textTheme.display4.color),
        onPressed: () => dispatch(PolularScienceDetailActionCreator.onClose()),
      ),
      elevation: 0,
      bottom: AppBarCorner(color: state.themeData.canvasColor),
    );
  }

  /// body
  Widget _body() {
    return SliverToBoxAdapter(
      child: Markdown(
        data: state.data,
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        imageBuilder: (uri) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(uri.toString()),
            ),
          );
        },
      ),
    );
  }

  return Scaffold(
    appBar: _appBar(),
    body: CustomScrollView(
      slivers: <Widget>[
        _body(),
      ],
    ),
  );
}
