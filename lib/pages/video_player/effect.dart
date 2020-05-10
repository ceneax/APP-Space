import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';
import 'package:wakelock/wakelock.dart';

import 'package:space/widgets/live_chat_list.dart';
import '../../config.dart';
import '../../utils/dialog_util.dart';

import 'action.dart';
import 'state.dart';

Effect<VideoPlayerState> buildEffect() {
  return combineEffects(<Object, Effect<VideoPlayerState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    VideoPlayerAction.willPop: _willPop,
    VideoPlayerAction.sendMsg: _sendMsg,
  });
}

/// 播放器事件监听
void _playerListener(Context<VideoPlayerState> ctx) {
  FijkValue value = ctx.state.player.value;

  if(value.prepared) {
    double tmpWidth, tmpHeight;

    tmpHeight = value.size.height;
    tmpWidth = value.size.width;

    if(tmpHeight != ctx.state.videoHeight || tmpWidth != ctx.state.videoWidth) {
      ctx.dispatch(VideoPlayerActionCreator.onSetVideoSize(tmpWidth, tmpHeight));
    }
  }
}

/// 初始化播放器
void _initPlayer(Context<VideoPlayerState> ctx) async {
  String url, referer;

  if(ctx.state.videoType == VideoType.LIVE || ctx.state.videoType == VideoType.NORMAL) {
    url = ctx.state.url;
  } else {
    var acid = ctx.state.url.toString().split('-');
    try {
      var res = await Dio().get('https://api.bilibili.com/x/player/playurl?avid=${acid[0]}&cid=${acid[1]}&otype=json');
      url = res.data['data']['durl'][0]['backup_url'][0];
    } catch(e) {
      url = '';
    }
  }

  if(ctx.state.referer != null && ctx.state.referer != '') {
    referer = 'Referer:${ctx.state.referer}\r\n';
  } else {
    referer = '';
  }

  await ctx.state.player.setOption(FijkOption.formatCategory, 'headers', '${referer}User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:56.0) Gecko/20100101 Firefox/56.0');
  
  ctx.state.player.addListener(() {
    _playerListener(ctx);
  });
  ctx.state.player.setDataSource(url, autoPlay: true);
}

void _initLive(Context<VideoPlayerState> ctx) async {
  await Socket.connect(Config.LIVE_SOCKET_HOST, Config.LIVE_SOCKET_PORT).then((Socket socket) {
    ctx.state.liveChatController.add(LiveChatBean(nickname: '系统消息', msg: '聊天频道服务器连接成功！！', color: Colors.green));
    ctx.dispatch(VideoPlayerActionCreator.onSetSocket(socket));
    
    ctx.state.socket.listen((res) {
      var msg = jsonDecode(Utf8Decoder().convert(res));

      switch(msg['type']) {
        case 1:
          ctx.dispatch(VideoPlayerActionCreator.onUpdateOnlineNum(msg['data']));
          break;
        case 100:
          ctx.state.liveChatController.add(LiveChatBean(nickname: msg['data']['nickname'], msg: msg['data']['msg']));
          break;
      }
    });
  }).catchError((e) {
    ctx.state.liveChatController.add(LiveChatBean(nickname: '系统消息', msg: '聊天频道服务器连接失败！！', color: Colors.redAccent));
  });
}

void _init(Action action, Context<VideoPlayerState> ctx) {
  Wakelock.enable(); /// 屏幕常亮
  _initPlayer(ctx);

  if(ctx.state.videoType == VideoType.LIVE)
    _initLive(ctx);
}

void _dispose(Action action, Context<VideoPlayerState> ctx) {
  Wakelock.disable(); /// 取消屏幕常亮
  ctx.state.player.release();
//  ctx.state.player.removeListener(_playerListener);

  if(ctx.state.socket != null)
    ctx.state.socket.close();
}

Future<bool> _willPop(Action action, Context<VideoPlayerState> ctx) {
  if(ctx.state.player.value.fullScreen) {
    ctx.state.player.exitFullScreen();
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}

void _sendMsg(Action action, Context<VideoPlayerState> ctx) {
  if(ctx.state.isLogin == false) {
    showToast('要先登陆才能一起聊天哦～～');
    return;
  }

  DialogUtil.showBottomSheetTextField(ctx.context, '想聊点什么', (content) {
    var msg = {
      'type': 100,
      'data': {
        'nickname': ctx.state.userInfo['nickname'],
        'msg': content.toString().length > 44 ? content.toString().substring(0, 43) : content
      }
    };

    ctx.state.socket.writeln(jsonEncode(msg));
    ctx.state.socket.flush();
  });
}