import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

import 'package:space/network/api.dart';
import 'package:space/network/api3.dart';
import 'package:space/utils/dialog_util.dart';

import 'action.dart';
import 'state.dart';

Effect<NewPostState> buildEffect() {
  return combineEffects(<Object, Effect<NewPostState>>{
    Lifecycle.dispose: _dispose,
    NewPostAction.closePage: _closePage,
    NewPostAction.addEmojiClick: _addEmojiClick,
    NewPostAction.addImageClick: _addImageClick,
    NewPostAction.sendPost: _sendPost,
  });
}

void _dispose(Action action, Context<NewPostState> ctx) {
  ctx.state.textEditingController.dispose();
}

void _closePage(Action action, Context<NewPostState> ctx) {
  Navigator.pop(ctx.context);
}

void _addEmojiClick(Action action, Context<NewPostState> ctx) {
  showToast('表情功能暂时没做，等等吧。。');
}

void _addImageClick(Action action, Context<NewPostState> ctx) async {
  /// 解决textField初始化值的时候光标错位
  ctx.state.textEditingController.text = ctx.state.textFieldContent;
  ctx.state.textEditingController.selection = TextSelection.collapsed(offset: ctx.state.textFieldContent.length);

  if(ctx.state.uploadImages.length >= 9) {
    showToast('最多只能上传9张图片昂！！');
    return;
  }

  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  if(image == null)
    return;

  ctx.dispatch(NewPostActionCreator.onAddedImage(image));
}

void _sendPost(Action action, Context<NewPostState> ctx) async {
  if(ctx.state.textFieldContent == null || ctx.state.textFieldContent == '') {
    showToast('你别逗我，什么都不写，发什么动态啊。。');
    return;
  }

  DialogUtil.showLoading(ctx.context, content: '在发帖，稍等～');
  var tmpImgUrls = [];

  if(ctx.state.uploadImages != null && ctx.state.uploadImages.length > 0) {
    for(File f in ctx.state.uploadImages) {
      var res = await Api3.getInstance().uploadFile(f, '/bbs');
      if(res == false) {
        DialogUtil.close(ctx.context);
        showToast('图片上传失败啦！！');
        return;
      }

      tmpImgUrls.add(res);
    }
  }

  var res2 = await Api.getInstance().sendPost(ctx.state.textFieldContent, ctx.state.userInfo['objectId'], ctx.state.userInfo['sessionToken'], image: tmpImgUrls);
  /// 判断结果是否209，账号是否过期
  if(res2 is int) {
    DialogUtil.close(ctx.context);
    showToast('出问题了，不知道什么问题，代码：$res2');
    return;
  }

  DialogUtil.close(ctx.context);
  Navigator.pop(ctx.context, 'refresh');
}