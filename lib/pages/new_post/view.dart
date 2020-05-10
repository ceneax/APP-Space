import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/widgets/app_bar_corner.dart';
import 'package:space/widgets/local_nine_grid_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(NewPostState state, Dispatch dispatch, ViewService viewService) {
  /// 返回appBar布局
  Widget _appBar() {
    return AppBar(
      backgroundColor: state.themeData.primaryColor,
      title: Text('要写点什么？', style: TextStyle(color: state.themeData.textTheme.display4.color)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: state.themeData.textTheme.display4.color),
        onPressed: () => dispatch(NewPostActionCreator.onClosePage()),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send, color: state.themeData.textTheme.display4.color),
          onPressed: () => dispatch(NewPostActionCreator.onSendPost()),
        )
      ],
      elevation: 0,
      bottom: AppBarCorner(color: state.themeData.canvasColor),
    );
  }

  /// 返回body布局
  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            minLines: 3,
            maxLines: 10,
            decoration: InputDecoration(
                helperText: '正经发言，不要挑战规则哦～'
            ),
            onChanged: (content) => dispatch(NewPostActionCreator.onTextFieldChanged(content)),
            controller: state.textEditingController,
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.image), // add_photo_alternate
                onPressed: () => dispatch(NewPostActionCreator.onAddImageClick()),
              ),
              IconButton(
                icon: Icon(Icons.sentiment_neutral),
                onPressed: () => dispatch(NewPostActionCreator.onAddEmojiClick()),
              )
            ],
          ),
          LocalNineGridImage(
            state.uploadImages,
            itemClose: (index, url, urlList) => dispatch(NewPostActionCreator.onDeleteImage(index)),
          )
        ],
      ),
    );
  }

  return Scaffold(
    appBar: _appBar(),
    body: _body(),
  );

}
