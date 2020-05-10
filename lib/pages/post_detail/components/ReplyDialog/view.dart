import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/utils/date_util.dart';
import 'package:space/widgets/lx_list_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PostDetailReplyDialogState state, Dispatch dispatch, ViewService viewService) {
  /// 返回第一行标题布局
  Widget _title() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              '回复详情',
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
    return InkWell(
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
                                  image: NetworkImage(state.replies[index]['author']['avatar'], headers: {'Referer': Config.UPY_STORAGE_REFERER})
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
                                state.replies[index]['author']['nickname'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeData.textTheme.display3.color
                                ),
                              ),
                              Offstage(
                                offstage: state.replies[index]['author']['objectId'] == state.replies[index]['comment']['author']['objectId'] ? false : true,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(
                                      '层主',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10
                                      )),
                                ),
                              )
                            ],
                          ),
                          Text( /// 发帖时间
                            DateUtil.format(DateTime.parse(state.replies[index]['createdAt'])),
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
                Expanded( /// 此处绘制操作按钮
                  child: Row( /// 之所以用Row，是为了以后增加按钮方便
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      PopupMenuButton(
                        itemBuilder: (BuildContext menuContext) {
                          List<PopupMenuEntry<PostDetailReplyDialogOption>> items = <PopupMenuEntry<PostDetailReplyDialogOption>>[
                            PopupMenuItem(
                              child: Text('举报'),
                              value: PostDetailReplyDialogOption.REPORT,
                            ),
                          ];

                          if(state.isLogin) {
                            if(state.userInfo['objectId'] == state.replies[index]['author']['objectId']) {
                              items.addAll(<PopupMenuEntry<PostDetailReplyDialogOption>>[
                                PopupMenuItem(
                                  child: Text('删除'),
                                  value: PostDetailReplyDialogOption.DELETE,
                                ),
                              ]);
                            }
                          }

                          return items;
                        },
                        onSelected: (value) => dispatch(PostDetailReplyDialogActionCreator.onDeleteReply(value, index)),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
            Container( /// 第二行，显示帖子内容
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                state.replies[index]['reply'] == null ? state.replies[index]['content'] : '回复 ${state.replies[index]['reply']['author']['username']}：${state.replies[index]['content']}',
              ),
            ),
          ],
        ),
      ),
      onTap: () => dispatch(PostDetailReplyDialogActionCreator.onSendReply(index)),
      onLongPress: () => dispatch(PostDetailReplyDialogActionCreator.onCopyToClipBoard(state.replies[index]['content'])),
    );
  }

  /// 返回主要布局listView
  Widget _listView() {
    return Flexible( /// 不加这个会报错
      child: LXListView.listView(
          builder: (context, index) => _listItem(index),
          itemCount: state.replies.length,
          loadMore: () async {
            await dispatch(PostDetailReplyDialogActionCreator.onLoadMore());
          },
      ),
    );
  }

  return  Column(
    children: <Widget>[
      _title(),
      _listView()
    ],
  );
}
