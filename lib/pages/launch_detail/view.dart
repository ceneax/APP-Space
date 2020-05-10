import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/pages/launch/action.dart';
import 'package:space/utils/date_util.dart';
import 'package:space/widgets/app_bar_corner.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LaunchDetailState state, Dispatch dispatch, ViewService viewService) {
  /// AppBar组件
  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: state.themeData.primaryColor,
      expandedHeight: state.expandedHeight,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: state.themeData.textTheme.display4.color),
        onPressed: () => dispatch(LaunchDetailActionCreator.onClosePage()),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'LaunchImage${state.data['objectId']}',
          child: state.data['rocket']['img'] == null || state.data['rocket']['img'] == '' ? Image.asset('images/rocket_default.png', fit: BoxFit.cover) : Image.network(state.data['rocket']['img'], fit: BoxFit.cover, headers: {'Referer': Config.UPY_STORAGE_REFERER}),
        ),
      ),
      elevation: 0,
      bottom: AppBarCorner(color: state.themeData.canvasColor),
    );
  }

  /// 返回一个圆角带阴影的布局，可以设置标题
  Widget _cornerShadowContainer(String title, Widget child, {String subTitle, double width, EdgeInsets margin}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
          color: state.themeData.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
//          boxShadow: [BoxShadow(
//            color: state.themeData.cardColor, //Color.fromARGB(255, 228, 228, 228)
//            offset: Offset(0, 0),
//            blurRadius: 5,
//          )]
      ),
      child: Column( /// 主布局
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container( /// 标题布局
            margin: EdgeInsets.only(bottom: 10),
            child: Text.rich(
                TextSpan(
                    text: title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: subTitle,
                          style: TextStyle(
                              fontSize: 12
                          )
                      )
                    ]
                )
            ),
          ),
          child, /// 传递过来的布局
        ],
      ),
    );
  }

  /// 返回处理后的发射状态
  List _launchStatus(int status) {
    List ret = [];

    /// 待发射
    if(state.launchStatus == LaunchStatus.UPCOMING) {
      ret.add('待发射');
      ret.add(Colors.blue);
      return ret;
    }

    /// 已发射
    switch(status) {
      case 0:
        ret.add('成功');
        ret.add(Colors.green);
        break;
      case 1:
        ret.add('失败');
        ret.add(Colors.red);
        break;
      case 2:
        ret.add('部分成功');
        ret.add(Colors.yellow);
        break;
    }

    return ret;
  }

  /// body的第一行布局
  Widget _bodyOneRow() {
    return Row( /// 主布局第一行
      children: <Widget>[
        Expanded( /// 这个组件将Row默认划分为1:1，可以用flex指定比例
          child: _cornerShadowContainer(
              '发射状态',
              Text(
                _launchStatus(state.data['launch_status'])[0],
                style: TextStyle(
                    color: _launchStatus(state.data['launch_status'])[1],
                    fontSize: 12
                ),
              ),
              margin: EdgeInsets.only(right: 5)
          ),
        ),
        Expanded(
          child: _cornerShadowContainer(
              '发射日期',
              Text(
                '${DateUtil.transUTC2LocalString(state.data['launch_net'])} GMT+8',
                style: TextStyle(
                    fontSize: 12,
                    color: state.themeData.textTheme.display2.color
                ),
              ),
              margin: EdgeInsets.only(left: 5)
          ),
        ),
      ],
    );
  }

  /// 返回布局的子布局，一个富文本组件的封装
  Widget _bodyRichText(String title, String args) {
    return Text.rich(
      TextSpan(
          style: TextStyle(fontSize: 12),
          text: title,
          children: <TextSpan>[
            TextSpan(
                text: args,
                style: TextStyle(
                    color: state.themeData.textTheme.display2.color
                )
            )
          ]
      ),
    );
  }

  /// 返回布局的第二行
  Widget _bodyTwo() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row( /// 主布局
        children: <Widget>[
          Expanded( /// 此处组件目的是为了让主布局宽度占满父布局
            child: _cornerShadowContainer( /// 圆角组件
                '火箭参数：',
                Row( /// 给布局分两列
                  children: <Widget>[
                    Expanded( /// 第一列
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                        children: <Widget>[
                          _bodyRichText('箭体高度：', '${state.data['rocket']['height'].toString()}米'),
                          _bodyRichText('LEO：', '${state.data['rocket']['payload_leo'].toString()}千克'),
                          _bodyRichText('GTO：', '${state.data['rocket']['payload_gto'].toString()}千克'),
                          _bodyRichText('起飞推力：', '${state.data['rocket']['liftoff_thrust'].toString()}千牛'),
                          _bodyRichText('阶段：', '${state.data['rocket']['stages'].toString()}'),
                        ],
                      ),
                    ),
                    Expanded( /// 第二列
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                        children: <Widget>[
                          _bodyRichText('助推器：', '${state.data['rocket']['strap_ons'].toString()}个'),
                          _bodyRichText('整流罩直径：', '${state.data['rocket']['fairing_diameter'].toString()}米'),
                          _bodyRichText('整流罩高度：', '${state.data['rocket']['fairing_height'].toString()}米'),
                          _bodyRichText('造价：', '${state.data['rocket']['price'].toString()}美元'),
                          _bodyRichText('状态：', '${state.data['rocket']['status']}'),
                        ],
                      ),
                    ),
                  ],
                ),
                subTitle: state.data['rocket']['name']
            ),
          )
        ],
      ),
    );
  }

  /// 返回第三行布局
  Widget _bodyThree() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row( /// 主布局
        children: <Widget>[
          Expanded(
            child: _cornerShadowContainer(
                '发射基地',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                  children: <Widget>[
                    _bodyRichText('国家代码：', '${state.data['location']['country_code']}'),
                    _bodyRichText('位置：', '${state.data['location']['name']}'),
                  ],
                ),
                margin: EdgeInsets.only(right: 5)
            ),
          ),
          Expanded(
            child: _cornerShadowContainer(
                '基地信息',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                  children: <Widget>[
                    _bodyRichText('代码：', '${state.data['pad']['name']}'),
                    _bodyRichText('经度：', '${state.data['pad']['longitude'].toString()}'),
                    _bodyRichText('纬度：', '${state.data['pad']['latitude'].toString()}'),
                  ],
                ),
                margin: EdgeInsets.only(left: 5)
            ),
          )
        ],
      ),
    );
  }

  /// 返回第四行布局
  Widget _bodyFour() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row( /// 主布局
        children: <Widget>[
          Expanded( /// 使子布局占满父布局
            child: _cornerShadowContainer( /// 子布局
                '发射机构',
                Row( /// 将子布局分成两列
                  children: <Widget>[
                    Expanded( /// 第一列
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                        children: <Widget>[
                          _bodyRichText('简称：', '${state.data['agency']['abbrev']}'),
                          _bodyRichText('名称：', '${state.data['agency']['name']}'),
                        ],
                      ),
                    ),
                    Expanded( /// 第二列
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                        children: <Widget>[
                          _bodyRichText('性质：', state.data['agency']['government'] ? '政府机构' : '民营机构'),
                          _bodyRichText('国家代码：', '${state.data['agency']['country_code']}'),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

  /// 返任务简介布局模板
  Widget _bodyFiveTemp(String title, var obj) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row( /// 主布局
        children: <Widget>[
          Expanded( /// 使子布局占满父布局
            child: _cornerShadowContainer( /// 子布局
                title, /// 传递过来的标题
                Column( /// 将子布局分成两行
                  crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                  children: <Widget>[
                    Row( /// 第一行，将子布局分成两列
                      children: <Widget>[
                        Expanded( /// 第一列
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                            children: <Widget>[
                              _bodyRichText('载荷：', '${obj['mission_name']}'),
                              _bodyRichText('轨道：', '${obj['orbit_abbrev']}'),
                            ],
                          ),
                        ),
                        Expanded( /// 第二列
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, /// 让子布局靠左对齐
                            children: <Widget>[
                              _bodyRichText('质量：', '${obj['mission_mass'].toString()}千克'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _bodyRichText('任务描述：', '${obj['mission_description']}'), /// 第二行
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

  /// 返回第五行布局，即：任务简介。可能会返回多个布局
  Widget _bodyFive() {
    List<Widget> widgets = <Widget>[];
    var objs = [];

    objs = state.data['mission'];

    for(var i = 0; i < objs.length; i ++) {
      if(objs.length == 1) {
        widgets.add(_bodyFiveTemp('任务简介', objs[i]));
      } else {
        widgets.add(_bodyFiveTemp('任务${i + 1}的简介', objs[i]));
      }
    }

    return Column(
      children: widgets,
    );
  }

  /// 返回主布局
  Widget _body() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _bodyOneRow(),
            _bodyTwo(),
            _bodyThree(),
            _bodyFour(),
            _bodyFive(),
          ],
        ),
      ),
    );
  }

  return Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        _appBar(),
        _body()
      ],
    ),
    floatingActionButton: Offstage(
      offstage: state.data['video'] == null || state.data['video'] == '',
      child: FloatingActionButton(
        backgroundColor: state.themeData.primaryColor,
//      heroTag: 'LaunchDetailTag',
        child: Icon(Icons.play_circle_outline),
        onPressed: () => dispatch(LaunchDetailActionCreator.onShowVideo()),
      ),
    ),
  );
}
