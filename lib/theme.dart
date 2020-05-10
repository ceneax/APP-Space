import 'package:flutter/material.dart';

enum ThemeType { LIGHT_DEFAULT, DARK_DEFAULT, LIGHT_RED, LIGHT_GREEN, LIGHT_RED_SPECIAL, LIGHT_GREY_SPECIAL }

/// 自定义的Theme数据
/// 在app中，凡是遇到需要自己赋值一个颜色的情况，都要用这里的ThemeStyle的颜色数据
/// 目的为了动态切换主题方便
class ThemeStyle {

  /// 默认亮色主题
  static final lightThemeDefault = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    textTheme: ThemeData.light().textTheme.copyWith(
          display3: TextStyle(
            color: Colors.black
          ),
          display4: TextStyle(
              color: Colors.white
          )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
    )
  );

  /// 默认暗色主题
  static final darkThemeDefault = ThemeData.dark().copyWith(
      primaryColor: Colors.grey[900],
      textTheme: ThemeData.dark().textTheme.copyWith(
          display3: TextStyle(
              color: Colors.white
          ),
          display4: TextStyle(
              color: Colors.white
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white
      )
  );

  /// 红色-亮色主题
  static final lightThemeRed = ThemeData.light().copyWith(
      primaryColor: Colors.red,
      textTheme: ThemeData.light().textTheme.copyWith(
          display3: TextStyle(
              color: Colors.black
          ),
        display4: TextStyle(
          color: Colors.white
        )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white
      )
  );

  /// 绿色-亮色主题
  static final lightThemeGreen = ThemeData.light().copyWith(
      primaryColor: Colors.green,
      textTheme: ThemeData.light().textTheme.copyWith(
          display3: TextStyle(
              color: Colors.black
          ),
          display4: TextStyle(
              color: Colors.white
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white
      )
  );

  /// 红色-特殊-亮色主题-用户无法选择和修改-由服务端控制
  static final lightThemeRedSpecial = ThemeData.light().copyWith(
      primaryColor: Colors.red,
      textTheme: ThemeData.light().textTheme.copyWith(
          display3: TextStyle(
              color: Colors.red
          ),
          display4: TextStyle(
              color: Colors.yellow
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.red,
          foregroundColor: Colors.yellow
      )
  );

  /// 灰色-特殊-亮色主题-用户无法选择和修改-由服务端控制
  static final lightThemeGreySpecial = ThemeData.light().copyWith(
      primaryColor: Colors.grey,
      textTheme: ThemeData.light().textTheme.copyWith(
          display3: TextStyle(
              color: Colors.grey
          ),
          display4: TextStyle(
              color: Colors.white
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white
      )
  );

}