import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/widgets/live_chat_list.dart';
import '../../utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VideoPlayerState state, Dispatch dispatch, ViewService viewService) {
  /// 构建播放器
  Widget _playerHeader() {
    return Container(
      padding: EdgeInsets.only(top: WidgetUtil.getStatusBarHeight()),
      color: Colors.black,
      child: FijkView(
        height: WidgetUtil.getScreenWidth() * state.videoHeight / state.videoWidth,
        player: state.player,
        panelBuilder: fijkPanel2Builder(fill: true),
        color: Colors.black,
      ),
    );
  }

  /// 中间圆角
  Widget _headerCorner() {
    return Container(
      height: 20,
      color: Colors.black,
      foregroundDecoration: BoxDecoration(
          color: state.themeData.canvasColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
    );
  }

  /// 构建直播界面
  Widget _liveModeLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Text(
                '直播',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),
              ),
            ),
            Text('当前在线：${state.onlineNum}', style: TextStyle(fontSize: 12)),
          ],
        ),
        Expanded(
          child: LiveChatList(
            controller: state.liveChatController,
            nickNameColor: state.themeData.textTheme.display3.color,
          ),
        ),
        GestureDetector(
          child: Container(
            width: double.infinity,
            color: state.themeData.cardColor,
            padding: EdgeInsets.all(10),
            child: Text('来一起聊天~', style: TextStyle(color: state.themeData.textTheme.display1.color)),
          ),
          onTap: () => dispatch(VideoPlayerActionCreator.onSendMsg()),
        ),
      ],
    );
  }

  /// 构建普通播放界面
  Widget _normalModeLayout() {
    return Container();
  }

  /// 返回body
  Widget _body() {
    if(state.videoType == VideoType.LIVE)
      return _liveModeLayout();

    return _normalModeLayout();
  }

  return WillPopScope(
    child: Scaffold(
      body: Column(
        children: <Widget>[
          _playerHeader(),
          _headerCorner(),
          Flexible(
            child: _body(),
          )
        ],
      ),
    ),
    onWillPop: () async {
      return await dispatch(VideoPlayerActionCreator.onWillPop());
    },
  );
}
