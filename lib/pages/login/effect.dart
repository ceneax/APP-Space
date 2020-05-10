import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/global_store/action.dart';
import 'package:space/global_store/store.dart';
import 'package:space/network/api.dart';
import 'package:space/utils/app_util.dart';

import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.registerPage: _registerPage,
    LoginAction.login: _login,
  });
}

void _registerPage(Action action, Context<LoginState> ctx) {
  Navigator.pushNamed(ctx.context, 'register_page');
}

void _login(Action action, Context<LoginState> ctx) async {
  if(ctx.state.username == null || ctx.state.username == '') {
    showToast('用户名先输上去，不然怎么登陆。。');
    return;
  }
  if(ctx.state.password == null || ctx.state.password == '') {
    showToast('密码都不准备填了么。。。');
    return;
  }

  var res = await Api.getInstance().login(ctx.state.username, ctx.state.password);

  if(res is int) {
    showToast('用户名或者密码有问题，你看看是不是输入错了。。');
  } else {
    GlobalStore.store.dispatch(GlobalActionCreator.onLogin(res));
    Navigator.pop(ctx.context);
  }
}