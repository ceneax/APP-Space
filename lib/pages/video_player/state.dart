import 'dart:io';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/video_player/action.dart';
import 'package:space/widgets/live_chat_list.dart';

import '../../global_store/state.dart';

class VideoPlayerState implements Cloneable<VideoPlayerState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  String url, referer;
  VideoType videoType;

  double videoHeight, videoWidth;
  FijkPlayer player;

  LiveChatController liveChatController;
  Socket socket;
  int onlineNum;

  @override
  VideoPlayerState clone() {
    return VideoPlayerState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..url = url
      ..referer = referer
      ..videoType = videoType
      ..videoWidth = videoWidth
      ..videoHeight = videoHeight
      ..player = player
      ..liveChatController = liveChatController
      ..socket = socket
      ..onlineNum = onlineNum;
  }

}

VideoPlayerState initState(Map<String, dynamic> args) {
  return VideoPlayerState()
    ..url = args['url']
    ..videoType = args['type']
    ..referer = args['referer']
    ..videoHeight = 1080
    ..videoWidth = 1920
    ..player = FijkPlayer()
    ..liveChatController = args['type'] == VideoType.LIVE ? LiveChatController() : null
    ..onlineNum = 0;
}