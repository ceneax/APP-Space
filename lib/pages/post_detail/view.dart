import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/utils/date_util.dart';
import 'package:space/widgets/app_bar_corner.dart';
import 'package:space/widgets/lx_sliver_list_view.dart';
import 'package:space/widgets/nine_grid_image.dart';
import 'package:space/widgets/sliver_persistent_header_delegate.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PostDetailState state, Dispatch dispatch, ViewService viewService) {
  /// 构建appBar
  Widget _appBar() {
    return AppBar(
      backgroundColor: state.themeData.primaryColor,
      title: Text('详情', style: TextStyle(color: state.themeData.textTheme.display4.color)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: state.themeData.textTheme.display4.color),
        onPressed: () => dispatch(PostDetailActionCreator.onClosePage()),
      ),
      elevation: 0,
      bottom: AppBarCorner(color: state.themeData.canvasColor),
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            List<PopupMenuEntry<PostDetailOption>> items = <PopupMenuEntry<PostDetailOption>>[
              PopupMenuItem(
                child: Text('收藏'),
                value: PostDetailOption.MARK,
              ),
            ];

            if(state.isLogin) {
              if(state.userInfo['objectId'] == state.post['author']['objectId']) {
                items.addAll(<PopupMenuEntry<PostDetailOption>>[
                  PopupMenuItem(
                    child: Text('编辑'),
                    value: PostDetailOption.EDIT,
                  ),
                  PopupMenuItem(
                    child: Text('删除'),
                    value: PostDetailOption.DELETE,
                  ),
                ]);
              }
            }

            return items;
          },
          onSelected: (PostDetailOption value) => dispatch(PostDetailActionCreator.onSelectMenu(value)),
        )
      ],
    );
  }

  /// 返回帖子header
  Widget _header() {
    return SliverToBoxAdapter(
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
                          child: Hero(
                            tag: 'PostAvatar${state.post['objectId']}',
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(state.post['author']['avatar'], headers: {'Referer': Config.UPY_STORAGE_REFERER})
                                  )
                              ),
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
                                  state.post['author']['nickname'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: state.themeData.textTheme.display3.color,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Offstage(
                                  offstage: state.post['author']['role'] == 0 ? false : true,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                        '管理',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Text( /// 发帖时间
                              DateUtil.format(DateTime.parse(state.post['createdAt'])),
                              style: TextStyle(
                                  color: state.themeData.textTheme.display1.color,
                                  fontSize: 12
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container( /// 第二行，显示帖子内容
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  state.post['content'],
                    style: TextStyle(
                        fontSize: 15
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: NineGridImage( /// 第三行，显示图片
                  state.post['image'],
                  header: {'Referer': Config.UPY_STORAGE_REFERER},
                  itemClick: (pos, url, list) => dispatch(PostDetailActionCreator.onShowImage(pos, list)),
                ),
              )
            ],
          ),
        ),
        onLongPress: () => dispatch(PostDetailActionCreator.onCopyToClipBoard(state.post['content'])),
      ),
    );
  }

  /// 返回评论header
  Widget _commentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: MySliverPersistentHeaderDelegate(
          minHeight: 40,
          maxHeight: 40,
          child: Container(
            color: state.themeData.canvasColor,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '评论(${state.post['commentNum']})',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: FlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('排序'),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                        onPressed: () {}, /// Todo coding...
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  /// 返回listViewItem
  Widget _commentListViewItem(int index) {
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
                                  image: NetworkImage(state.comments[index]['author']['avatar'], headers: {'Referer': Config.UPY_STORAGE_REFERER})
                              )
                          ),
                        ),
                        onTap: () {}, // Todo 未完成的代码
                      ),
                      Column( /// 第二列，分成两行，分别是昵称和发帖时间
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text( /// 昵称
                                state.comments[index]['author']['nickname'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeData.textTheme.display3.color
                                ),
                              ),
                              Offstage(
                                offstage: state.comments[index]['author']['objectId'] == state.post['author']['objectId'] ? false : true,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(
                                      '楼主',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10
                                      )),
                                ),
                              )
                            ],
                          ),
                          Text( /// 发帖时间
                            DateUtil.format(DateTime.parse(state.comments[index]['createdAt'])),
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
                          List<PopupMenuEntry<PostDetailCommentOption>> items = <PopupMenuEntry<PostDetailCommentOption>>[
                            PopupMenuItem(
                              child: Text('举报'),
                              value: PostDetailCommentOption.REPORT,
                            ),
                          ];

                          if(state.isLogin) {
                            if(state.userInfo['objectId'] == state.comments[index]['author']['objectId']) {
                              items.addAll(<PopupMenuEntry<PostDetailCommentOption>>[
                                PopupMenuItem(
                                  child: Text('删除'),
                                  value: PostDetailCommentOption.DELETE,
                                ),
                              ]);
                            }
                          }

                          return items;
                        },
                        onSelected: (value) => dispatch(PostDetailActionCreator.onSelectCommentMenu(value, index)),
                      )
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
            Container( /// 第二行，显示帖子内容
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                state.comments[index]['content'],
              ),
            ),
            Offstage( /// 查看回复 按钮
              offstage: state.comments[index]['replyNum'] > 0 ? false : true,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 40),
                child: InkWell(
                  child: Container(
                    child: Text(
                      '查看回复',
                      style: TextStyle(
                          fontSize: 12,
                          color: state.themeData.textTheme.display1.color
                      ),
                    ),
                  ),
                  onTap: () => dispatch(PostDetailActionCreator.onShowReply(state.comments[index]['objectId'])),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => dispatch(PostDetailActionCreator.onSendReply(index)),
      onLongPress: () => dispatch(PostDetailActionCreator.onCopyToClipBoard(state.comments[index]['content'])),
    );
  }

  /// 返回评论listview
  Widget _commentListView() {
    return LXSliverListView.listView(
        builder: (context, index) => _commentListViewItem(index),
        itemCount: state.comments.length,
        controller: state.scrollController,
        loadMore: () async {
          await dispatch(PostDetailActionCreator.onLoadMore());
        },
    );
  }

  /// 返回body
  Widget _body() {
    if(!state.existPost) {
      return  Center(
        child: Text('这个动态获取失败啦！！'),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        _header(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        _commentHeader(),
        _commentListView(),
      ],
      physics: AlwaysScrollableScrollPhysics(),
      controller: state.scrollController,
    );
  }

  return Scaffold(
    appBar: _appBar(),
    body: RefreshIndicator(
      child: _body(),
      onRefresh: () async {
        return await dispatch(PostDetailActionCreator.onRefresh());
      },
    ),
    floatingActionButton: Offstage(
      offstage: !state.existPost,
      child: FloatingActionButton(
        backgroundColor: state.themeData.primaryColor,
//        heroTag: 'PostDetailTag',
        child: Icon(Icons.chat),
        onPressed: () => dispatch(PostDetailActionCreator.onSendComment()),
      ),
    ),
  );
}
