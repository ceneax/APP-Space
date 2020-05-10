import 'package:flutter/material.dart';

/// 枚举，LXSliverListView的类型
enum _LXSliverListViewType {
  LIST_VIEW,
  GRID_VIEW
}

typedef LXSliverListItemBuilder(BuildContext context, int index);
typedef OnLXSliverListLoadMore();

/// 封装了ListView和GridView
/// 并且增加了下拉刷新和上拉加载更多的功能
class LXSliverListView extends StatefulWidget {

  /// 定义LXSliverListView的类型
  _LXSliverListViewType _type;

  /// 共用属性
  final LXSliverListItemBuilder builder;
  final int itemCount;
  final EdgeInsets padding;
  final ScrollController controller;
  final OnLXSliverListLoadMore loadMore;

  /// GridView属性
  int crossAxisCount; /// 横轴元素个数
  double crossAxisSpacing; /// 横轴间距
  double mainAxisSpacing; /// 纵轴间距
  double childAspectRatio; /// 子组件宽高长度比例

  /// ListView构造函数
  LXSliverListView.listView({
    @required this.builder,
    @required this.itemCount,
    @required this.controller,
    this.padding,
    this.loadMore
  }) {
    this._type = _LXSliverListViewType.LIST_VIEW;
  }

  /// GridView构造函数
  LXSliverListView.gridView({
    @required this.builder,
    @required this.itemCount,
    @required this.controller,
    this.padding,
    this.crossAxisCount,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.childAspectRatio,
    this.loadMore
  }) {
    this._type = _LXSliverListViewType.GRID_VIEW;
  }

  @override
  State<StatefulWidget> createState() => _LXSliverListViewState();

}

class _LXSliverListViewState extends State<LXSliverListView> {

  bool isLoadingMore = false;

  /// 加载更多
  /// 在外部使用loadMore方法的时候，每个异步代码前加上await
  void _loadMore() async {
    isLoadingMore = true;
    await widget.loadMore();
    isLoadingMore = false;
  }

  @override
  void initState() {
    super.initState();

    /// 监听滚动事件
    if(widget.controller != null) {
      widget.controller.addListener(() {
        if(widget.controller.position.pixels == widget.controller.position.maxScrollExtent) { /// 已经滑动到listView底部了
          if(widget.loadMore != null || isLoadingMore == false) {
            _loadMore();
          }
        } else if(widget.controller.position.pixels == widget.controller.position.minScrollExtent) {
          /// 滑动到顶部了，下拉刷新目前未实现
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
//    if(widget.controller != null) {
//      widget.controller.dispose();
//    }
  }

  /// 构建SliverListView
  Widget _buildSliverListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(widget.builder, childCount: widget.itemCount),
    );
  }

  /// 构建SliverGridView
  Widget _buildSliverGridView() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(widget.builder, childCount: widget.itemCount),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount ??= 2,
        crossAxisSpacing: widget.crossAxisSpacing ??= 10,
        mainAxisSpacing: widget.mainAxisSpacing ??= 20,
        childAspectRatio: widget.childAspectRatio ??= 1
      )
    );
  }

  /// 构建SliverPadding
  Widget _buildSliverPadding(Widget sliver) {
    return SliverPadding(
      padding: widget.padding ?? EdgeInsets.all(0),
      sliver: sliver,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget._type == _LXSliverListViewType.LIST_VIEW) {
      return _buildSliverPadding(_buildSliverListView());
    } else {
      return _buildSliverPadding(_buildSliverGridView());
    }
  }

}