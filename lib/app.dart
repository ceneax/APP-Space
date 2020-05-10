import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

import 'package:space/global_store/store.dart';
import 'package:space/routes/fade_route.dart';

import 'routes/routes.dart';

/// 这里是创建了app的根Widget
Widget createApp() {
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染(runApp())之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  return OKToast(
    child: MaterialApp(
      title: '星辰大海',
      debugShowCheckedModeBanner: false,
      theme: GlobalStore.store.getState().themeData,
//    darkTheme: _darkTheme,
      home: Routes.routes.buildPage('main_page', null), /// 这里声明app要加载的第一个页面
      onGenerateRoute: (RouteSettings settings) {
        return FadeRoute(page: Routes.routes.buildPage(settings.name, settings.arguments));
      },
//      onGenerateRoute: (RouteSettings settings) {
//        return MaterialPageRoute<Object>(builder: (BuildContext context) {
//          return Routes.routes.buildPage(settings.name, settings.arguments);
//        });
//      },
    ),
  );
}