import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/global_store/action.dart';
import 'package:space/global_store/store.dart';
import 'package:space/network/api.dart';
import 'package:space/utils/app_util.dart';
import 'package:space/utils/dialog_util.dart';
import 'package:url_launcher/url_launcher.dart';

import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    Lifecycle.initState: _initState,
    MainAction.receivedBroadcast: _receivedBroadcast,
  });
}

void _initState(Action action, Context<MainState> ctx) async {
  /// 检测更新
  var updateRes = await Api.getInstance().getVersion();
  if(updateRes is int) {
    /// 什么都不做
  } else {
    var versionInfo = await AppUtil.getAppVersionInfo();
    if(versionInfo['versionCode'] != updateRes['versionCode']) {
      DialogUtil.showMyDialog(ctx.context, '有更新啦！！', '新版本：${updateRes['versionName']}\n\n更新内容：\n${updateRes['content']}', okText: '更新', cancelText: '偏不更新', okAction: () async {
        String url;

        if(Platform.isIOS) {
          url = 'itms-apps://itunes.apple.com/cn/app/idxxxx?mt=8';
        } else if(Platform.isAndroid) {
          url = updateRes['url'];
        } else {
          url = '';
        }

        if(await canLaunch(url))
          await launch(url);
        else
          showToast('更新失败啦！！好像是跳转到浏览器的过程中出问题了。。');
      });
    }
  }

  /// 获取消息通知
  if(ctx.state.isLogin) {
    var res = await Api.getInstance().checkNotification(ctx.state.userInfo['sessionToken'], ctx.state.userInfo['objectId']);
    if(res is int) {
      ctx.dispatch(MainActionCreator.onChangeNoticeNum(0));
    } else {
      ctx.dispatch(MainActionCreator.onChangeNoticeNum(res['result']));
    }
  }
}

void _receivedBroadcast(Action action, Context<MainState> ctx) async {
  ctx.dispatch(MainActionCreator.onChangeNoticeNum(action.payload));
}