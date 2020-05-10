import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/config.dart';
import 'package:space/utils/date_util.dart';
import 'package:space/widgets/lx_list_view.dart';
import 'package:space/widgets/nine_grid_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DiscuzState state, Dispatch dispatch, ViewService viewService) {
  /// 返回listView的item布局
  Widget _listViewItem(int index) {
    return InkWell(
      child: Container( /// 主布局
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
                          tag: 'PostAvatar${state.posts[index]['objectId']}',
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(state.posts[index]['author']['avatar'], headers: {'Referer': Config.UPY_STORAGE_REFERER})
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
                                state.posts[index]['author']['nickname'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: state.themeData.textTheme.display3.color,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Offstage(
                                offstage: state.posts[index]['top'] ? false : true,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(
                                      '置顶',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10
                                      )),
                                ),
                              )
                            ],
                          ),
                          Text( /// 发帖时间
                            '回复于${DateUtil.format(DateTime.parse(state.posts[index]['updatedAt']))}',
                            style: TextStyle(
                                color: state.themeData.textTheme.display1.color,
                                fontSize: 12
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  flex: 4, /// 两列的比例
                ),
//                Expanded( /// 此处绘制操作按钮
//                  child: Row( /// 之所以用Row，是为了以后增加按钮方便
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      PopupMenuButton(
//                        itemBuilder: (BuildContext menuContext) {
//                          List<PopupMenuEntry<DisCuzPostOption>> items = <PopupMenuEntry<DisCuzPostOption>>[
//                            PopupMenuItem(
//                              child: Text('举报'),
//                              value: DisCuzPostOption.REPORT,
//                            ),
//                          ];
//                          return items;
//                        },
//                        onSelected: (value) {}, /// Todo conding...
//                      )
//                    ],
//                  ),
//                  flex: 1,
//                ),
              ],
            ),
            Container( /// 第二行，显示帖子内容
              margin: EdgeInsets.only(top: 10),
              child: Text(
                state.posts[index]['content'],
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: NineGridImage( /// 第三行，显示图片
                state.posts[index]['image'],
                header: {'Referer': Config.UPY_STORAGE_REFERER},
                itemClick: (pos, url, list) => dispatch(DiscuzActionCreator.onShowImage(pos, list)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row( /// 底部操作
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.thumb_up, size: 17, color: state.themeData.textTheme.display1.color),
                        Text(
                          '0',
                          style: TextStyle(
                              color: state.themeData.textTheme.display1.color,
                              fontSize: 13
                          ),
                        )
                      ],
                    ),
                    onTap: () {}, /// TODO
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.chat_bubble_outline, size: 17, color: state.themeData.textTheme.display1.color),
                        Text(
                          '${state.posts[index]['commentNum']}',
                          style: TextStyle(
                              color: state.themeData.textTheme.display1.color,
                              fontSize: 13
                          ),
                        )
                      ],
                    ),
                  ),
//                  Row(
//                    children: <Widget>[
//                      Icon(Icons.share, size: 17, color: state.themeData.textTheme.display1.color),
//                    ],
//                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => dispatch(DiscuzActionCreator.onPostDetailPage(index)),
    );
  }

  /// 构建ListView
  Widget _listView() {
    return LXListView.listView(
      builder: (context, index) => _listViewItem(index),
      itemCount: state.posts.length,
      loadMore: () async {
        await dispatch(DiscuzActionCreator.onLoadMore());
      },
    );
  }

  return Scaffold(
    body: RefreshIndicator(
      child: _listView(),
      onRefresh: () {
        return dispatch(DiscuzActionCreator.onRefresh());
      },
    ),
    floatingActionButton: FloatingActionButton(
//      heroTag: 'DiscuzTag',
      backgroundColor: state.themeData.primaryColor,
      child: Icon(Icons.add),
      onPressed: () => dispatch(DiscuzActionCreator.onNewPostPage()),
    ),
  );
}
