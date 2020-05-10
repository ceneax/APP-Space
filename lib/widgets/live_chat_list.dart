import 'package:flutter/material.dart';

class LiveChatList extends StatefulWidget {

  final LiveChatController controller;
  final Color nickNameColor;
  final Color msgColor;

  LiveChatList({
    Key key,
    @required this.controller,
    this.nickNameColor = Colors.black,
    this.msgColor = Colors.black,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LiveChatListState();

}

class _LiveChatListState extends State<LiveChatList> {

  List<LiveChatBean> items = <LiveChatBean>[];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    /// 有新的item被添加，执行此事件
    widget.controller.add = (LiveChatBean bean) {
      setState(() {
        items.add(bean);

        if(items.length > 30) {
          items.removeAt(0);
        }

        scrollController.animateTo(scrollController.position.maxScrollExtent + 50, duration: Duration(milliseconds: 200), curve: Curves.linear);
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  /// item布局
  Widget _item(index) {
    Color nickColor = widget.nickNameColor;
    Color msgColor = widget.msgColor;

    if(items[index].color != null) {
      nickColor = items[index].color;
      msgColor = items[index].color;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${items[index].nickname}：',
            style: TextStyle(
                color: nickColor
            ),
          ),
          Expanded(
            child: Text(
              items[index].msg,
              maxLines: 2,
              style: TextStyle(
                  color: msgColor
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (listContext, index) {
        return _item(index);
      },
      itemCount: items.length,
      controller: scrollController,
    );
  }

}

class LiveChatBean {

  String _nickname;
  String _msg;
  Color _color;

  LiveChatBean({nickname, msg, color}) {
    _nickname = nickname;
    _msg = msg;
    _color = color;
  }

  String get nickname => _nickname;
  set nickname(String nickname) => _nickname = nickname;

  String get msg => _msg;
  set msg(String msg) => _msg = msg;

  Color get color => _color;
  set color(color) => _color = color;

}

class LiveChatController {
  dynamic add;
}