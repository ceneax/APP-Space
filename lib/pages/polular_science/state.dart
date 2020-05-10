import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../global_store/state.dart';

class PolularScienceState implements Cloneable<PolularScienceState>, GlobalBaseState {

  @override
  ThemeData themeData;

  @override
  dynamic userInfo;

  @override
  bool isLogin;

  var circleSelectorItem, circleSelectorItemData;

  ScrollController scrollController;

  int currentIndex;

  var polularSciences;
  int currentPage;

  @override
  PolularScienceState clone() {
    return PolularScienceState()
      ..themeData = themeData
      ..userInfo = userInfo
      ..isLogin = isLogin
      ..circleSelectorItem = circleSelectorItem
      ..circleSelectorItemData = circleSelectorItemData
      ..scrollController = scrollController
      ..currentIndex = currentIndex
      ..polularSciences = polularSciences
      ..currentPage = currentPage;
  }

}

PolularScienceState initState(Map<String, dynamic> args) {
  return PolularScienceState()
    ..circleSelectorItem = [Icons.settings_input_antenna, Icons.disc_full, Icons.contact_mail, Icons.account_balance, Icons.assignment]
    ..circleSelectorItemData = {
      '火箭科普': '科普关于火箭的各个参数、历史以及制造商等',
      '发动机科普': '科普关于火箭发动机的各个参数、历史以及制造商等',
      '发射机构科普': '科普国内外的政府机构和民营机构',
      '发射基地科普': '科普关于火箭发射基地的一些内容',
      '名词科普': '解释一些航天领域常用名词，如：LEO、上面级、变轨等'
    }
    ..scrollController = ScrollController()
    ..currentIndex = 0
    ..polularSciences = []
    ..currentPage = 1;
}