import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/global_store/state.dart';

class NewPostState implements Cloneable<NewPostState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  List<File> uploadImages;

  String textFieldContent;
  TextEditingController textEditingController;

  @override
  NewPostState clone() {
    return NewPostState()
      ..themeData = themeData
      ..isLogin = isLogin
      ..userInfo = userInfo
      ..uploadImages = uploadImages
      ..textFieldContent = textFieldContent
      ..textEditingController = textEditingController;
  }

}

NewPostState initState(Map<String, dynamic> args) {
  return NewPostState()
    ..uploadImages = []
    ..textFieldContent = ''
    ..textEditingController = TextEditingController();
}
