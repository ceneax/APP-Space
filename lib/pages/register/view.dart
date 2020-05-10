import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/utils/widget_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(RegisterState state, Dispatch dispatch, ViewService viewService) {
  /// 返回title布局
  Widget _title() {
    return Padding( /// 标题
      padding: EdgeInsets.fromLTRB(30, WidgetUtil.getStatusBarHeight() + kToolbarHeight, 30, 30),
      child: Text(
        '注册',
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
              helperText: '只能是英文和数字，用于登录',
              helperStyle: TextStyle(
                  color: Colors.white70
              ),
              suffixIcon: Icon(Icons.person, color: Colors.white70),
            ),
            maxLength: 20,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (content) => dispatch(RegisterActionCreator.onChangeUsername(content)),
          ),
          TextField( /// 昵称
            style: TextStyle(
                color: Colors.white70
            ),
            decoration: InputDecoration(
              labelText: '昵称',
              labelStyle: TextStyle(
                  color: Colors.white70
              ),
              helperText: '可以输入中文',
              helperStyle: TextStyle(
                  color: Colors.white70
              ),
              suffixIcon: Icon(Icons.person, color: Colors.white70),
            ),
            maxLength: 20,
            onChanged: (content) => dispatch(RegisterActionCreator.onChangeNickname(content)),
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
            onChanged: (content) => dispatch(RegisterActionCreator.onChangePassword(content)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: DropdownButton(
              items: [
                DropdownMenuItem(child: Text('男（雄的）'), value: 1),
                DropdownMenuItem(child: Text('女（雌的）'), value: 0)
              ],
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white70),
              value: state.dropDownButtonValue,
              hint: Text('选择你的性别'),
              onChanged: (value) => dispatch(RegisterActionCreator.onChangeSex(value)),
            ),
          ),
          Padding( /// 注册按钮
            padding: EdgeInsets.only(top: 30),
            child: FloatingActionButton(
//              heroTag: 'RegisterTag',
              backgroundColor: Colors.white70,
              child: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onPressed: () => dispatch(RegisterActionCreator.onReg()),
            ),
          ),
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
        _main()
      ],
    );
  }

  return Scaffold(
    body: _body(),
    backgroundColor: state.themeData.primaryColor,
  );
}
