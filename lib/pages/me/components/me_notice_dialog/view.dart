import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/utils/date_util.dart';
import 'package:space/widgets/lx_list_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MeNoticeDialogState state, Dispatch dispatch, ViewService viewService) {
  /// 返回第一行标题布局
  Widget _title() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              '回复我的',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 返回listItem
  Widget _listItem(int index) {
    String date = state.notice[index]['createdAt']; /// 不用判断是否为空
    String avatar, username;
    List<String> notificationContent = <String>[];
    bool available = true;

    if(state.notice[index]['type'] == 1) {
      if(state.notice[index]['comment'] == null) {
        available = false;
        avatar = 'http://img.space.lxiian.cn/avatar/avatar.png';
        username = '未知大佬';
        notificationContent = <String>['这条评论已经被删除了，无法查看。。', ''];
      } else {
        available = true;
        avatar = state.notice[index]['comment']['author']['avatar'];
        username = state.notice[index]['comment']['author']['nickname'];

        notificationContent = <String>['评论了你的帖子：${state.notice[index]['comment']['content']}', ''];
      }
    } else {
      if(state.notice[index]['reply'] == null) {
        available = false;
        avatar = 'http://img.space.lxiian.cn/avatar/avatar.png';
        username = '未知大佬';
        notificationContent = <String>['这条回复已经被删除了，无法查看。。', ''];
      } else {
        available = true;
        avatar = state.notice[index]['reply']['author']['avatar'];
        username = state.notice[index]['reply']['author']['nickname'];

        if(state.notice[index]['reply']['reply'] == null) {
          notificationContent = <String>['回复了你的评论：${state.notice[index]['reply']['content']}', '${state.notice[index]['reply']['comment']['content']}'];
        } else {
          notificationContent = <String>['回复了你的回复：${state.notice[index]['reply']['content']}', '${state.notice[index]['reply']['reply']['content']}'];
        }
      }
    }

    return Material(
      child: InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column( /// 将子布局分成几行
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row( /// 第一行，将子布局分成几列，此处绘制头像、昵称、发帖时间、操作按钮
                  children: <Widget>[
                    Expanded( /// 此处绘制头像、昵称、发帖时间
                      child: Row( /// 分成两列
                        children: <Widget>[
                          GestureDetector( /// 第一列，此处是头像
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(avatar, headers: {'Referer': Config.UPY_STORAGE_REFERER})
                                  )
                              ),
                            ),
                            onTap: () {}, /// Todo 未完成的代码
                          ),
                          Column( /// 第二列，分成两行，分别是昵称和发帖时间
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text( /// 昵称
                                    username,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: state.themeData.textTheme.display3.color
                                    ),
                                  ),
                                ],
                              ),
                              Text( /// 发帖时间
                                DateUtil.format(DateTime.parse(date)),
                                style: TextStyle(
                                    color: state.themeData.textTheme.display1.color,
                                    fontSize: 11
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      flex: 4,
                    ),
                  ],
                ),
                Container( /// 第二行，显示帖子内容
                  margin: EdgeInsets.only(top: 10, left: 40),
                  child: Text(
                      notificationContent[0]
                  ),
                ),
                Offstage( /// 引用内容
                  offstage: notificationContent[1] == '',
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(40, 10, 10, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: state.themeData.dialogBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text(
                      notificationContent[1],
                      style: TextStyle(
                          fontSize: 12,
                          color: state.themeData.textTheme.display1.color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            if(available)
              dispatch(MeNoticeDialogActionCreator.onJumpToPostDetail(index));
          }
      ),
    );
  }

  /// 返回主要布局listView
  Widget _listView() {
    return Flexible( /// 不加这个会报错
      child: LXListView.listView(
          builder: (context, index) => _listItem(index),
          itemCount: state.notice.length,
          loadMore: () async {
            await dispatch(MeNoticeDialogActionCreator.onLoadMore());
          },
      ),
    );
  }

  return Column(
    children: <Widget>[
      _title(),
      _listView()
    ],
  );
}
