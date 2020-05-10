import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api.dart';

import 'action.dart';
import 'state.dart';

Effect<RegisterState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterState>>{
    RegisterAction.reg: _reg,
  });
}

void _reg(Action action, Context<RegisterState> ctx) async {
  if(ctx.state.username == null || ctx.state.username == '') {
    showToast('用户名先输上去，不然怎么注册。。');
    return;
  }
  if(ctx.state.username.length > 20) {
    showToast('用户名太长了，想一个短一点的。。');
    return;
  }
  if(ctx.state.nickname == null || ctx.state.nickname == '') {
    showToast('昵称输上去，不然怎么注册。。');
    return;
  }
  if(ctx.state.nickname.length > 20) {
    showToast('昵称太长了，想一个短一点的昵称。。');
    return;
  }
  if(ctx.state.password == null || ctx.state.password == '') {
    showToast('密码都不准备填了么。。。');
    return;
  }
  if(ctx.state.dropDownButtonValue == null) {
    showToast('性别别忘了选了。。。。');
    return;
  }

  var res = await Api.getInstance().register(ctx.state.username, ctx.state.nickname, ctx.state.password, ctx.state.dropDownButtonValue.toString());

  if(res is int) {
    showToast('这个用户名已经被注册过啦，换一个呗～');
  } else {
    showToast('注册成功啦，去登陆吧！');
    Navigator.pop(ctx.context);
  }
}
