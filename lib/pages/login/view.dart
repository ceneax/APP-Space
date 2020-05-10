import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  /// 返回标题布局
  Widget _title() {
    return Padding( /// 标题
      padding: EdgeInsets.fromLTRB(30, WidgetUtil.getStatusBarHeight() + kToolbarHeight, 30, 30),
      child: Text(
        '登陆',
        style: TextStyle(
            color: state.themeData.textTheme.display4.color,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  /// 返回主体布局
  Widget _main() {
    return Container( /// Edittext和Button
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: <Widget>[
          TextField( /// 用户名
            style: TextStyle(
                color: Colors.white70
            ),
            decoration: InputDecoration(
              labelText: '用户名',
              labelStyle: TextStyle(
                  color: Colors.white70
              ),
              helperStyle: TextStyle(
                  color: Colors.white70
              ),
              suffixIcon: Icon(Icons.person, color: Colors.white70),
            ),
            maxLength: 20,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (content) => dispatch(LoginActionCreator.onChangeUsername(content)),
          ),
          TextField( /// 密码
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              style: TextStyle(
                  color: Colors.white70
              ),
              decoration: InputDecoration(
                  labelText: '密码',
                  labelStyle: TextStyle(
                      color: Colors.white70
                  ),
                  suffixIcon: Icon(Icons.vpn_key, color: Colors.white70)
              ),
              onChanged: (content) => dispatch(LoginActionCreator.onChangePassword(content))
          ),
          Padding( /// 登陆按钮
            padding: EdgeInsets.only(top: 30),
            child: FloatingActionButton(
//              heroTag: 'LoginTag',
              backgroundColor: Colors.white70,
              child: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onPressed: () => dispatch(LoginActionCreator.onLogin()),
            ),
          ),
          Padding( /// 注册跳转按钮
            padding: EdgeInsets.only(top: 30),
            child: FlatButton(
              child: Text(
                '俺莫得账号，俺要去注册',
                style: TextStyle(
                    color: Colors.white70
                ),
              ),
              onPressed: () => dispatch(LoginActionCreator.onRegisterPage()),
            ),
          )
        ],
      ),
    );
  }

  /// 返回body
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _title(),
        _main(),
      ],
    );
  }

  return Scaffold(
    body: _body(),
    backgroundColor: state.themeData.primaryColor,
  );

}
