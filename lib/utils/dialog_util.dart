import 'dart:ui';

import 'package:flutter/material.dart';

class DialogUtil {

  /// 显示通用普通弹出对话框
  static void showMyDialog(BuildContext myContext, String title, String content, {okText = '好的', cancelText, okAction, cancelAction}) {
    showDialog(
        context: myContext,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text( /// 标题
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    Padding( /// 内容
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(content),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton( /// 确认按钮
                          child: Text(okText),
                          onPressed: () {
                            if(okAction != null)
                              okAction();
                            close(context);
                          },
                        ),
                        Offstage(
                          offstage: cancelText == null,
                          child: FlatButton( /// 取消按钮
                            child: Text(cancelText == null ? '' : cancelText),
                            onPressed: () {
                              if(cancelAction != null)
                                cancelAction();
                              close(context);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  /// 显示通用列表选择对话框
  static void showGeneralList(BuildContext context, List<String> items, var action) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20))
        ),
        builder: (dialogContext) {
          List<Widget> widgets = <Widget>[];

          for(int i = 0; i < items.length; i ++) {
            widgets.add(ListTile(
              leading: Icon(Icons.list),
              title: Text(items[i]),
              onTap: () {
                close(dialogContext);
                action(i);
              },
            ));
          }

          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 设置弹窗为最小高度
              children: widgets,
            ),
          );
        }
    );
  }

  /// 显示loading对话框
  static void showLoading(BuildContext myContext, {String content = ''}) {
    showDialog(
        context: myContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ),
                    Text(content)
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  /// 显示带编辑框的底部弹窗对话框
  static void showBottomSheetTextField(BuildContext myContext, String title, var action) {
    String content;

    showModalBottomSheet(
        context: myContext,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20))
        ),
        builder: (BuildContext context) {
          return AnimatedPadding( /// 解决输入法弹出后，布局不自动向上顶的问题
            padding: MediaQueryData.fromWindow(window).viewInsets, /// 必须添加的参数，否则报错
            duration: Duration(milliseconds: 100), /// 必须添加的参数，否则报错
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Row( /// 第一行布局，标题、发送按钮
                    children: <Widget>[
                      Expanded( // 标题
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),
                      Expanded( /// 发送按钮
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if(content == null || content == '')
                                return;
                              action(content);
                              close(context);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextField( /// 第二行布局，文本框
                      minLines: 3,
                      maxLines: 3,
                      onChanged: (String value) {
                        content = value;
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  /// 关闭对话框
  static void close(BuildContext myContext) {
    Navigator.pop(myContext);
  }

}