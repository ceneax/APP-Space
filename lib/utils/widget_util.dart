import 'dart:ui';

import 'package:flutter/widgets.dart';

class WidgetUtil {

  /// 通过GlobalKey获取指定Widget的高度
  static double getWidgetHeight(GlobalKey key) {
    var keyContext = key.currentContext;

    if(keyContext != null) {
      var renderBox = keyContext.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }

    return 0;
  }

  /// 获取状态栏高度
  static double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }
  
  /// 获取屏幕宽度
  static double getScreenWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

}