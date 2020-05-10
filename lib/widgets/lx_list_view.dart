import 'package:flutter/material.dart';

/// 枚举，LXListView的类型
enum _LXListViewType {
  LIST_VIEW,
  GRID_VIEW
}

typedef LXListItemBuilder(BuildContext context, int index);
typedef OnLXListLoadMore();

/// 封装了ListView和GridView
/// 并且增加了下拉刷新和上拉加载更多的功能
class LXListView extends StatefulWidget {

  /// 定义LXSliverListView的类型
  _LXListViewType _type;

  /// 共用属性
  final LXListItemBuilder builder;
  final int itemCount;
  final EdgeInsets padding;
  final OnLXListLoadMore loadMore;

  /// GridView属性
  int crossAxisCount; /// 横轴元素个数
  double crossAxisSpacing; /// 横轴间距
  double mainAxisSpacing; /// 纵轴间距
  double childAspectRatio; /// 子组件宽高长度比例

  /// ListView构造函数
  LXListView.listView({
    @required this.builder,
    @required this.itemCount,
    this.padding,
    this.loadMore
  }) {
    this._type = _LXListViewType.LIST_VIEW;
  }

  /// GridView构造函数
  LXListView.gridView({
    @required this.builder,
    @required this.itemCount,
    this.padding,
    this.crossAxisCount,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.childAspectRatio,
    this.loadMore
  }) {
    this._type = _LXListViewType.GRID_VIEW;
  }

  @override
  State<StatefulWidget> createState() => _LXListViewState();

}

class _LXListViewState extends State<LXListView> {

  bool isLoadingMore = false;

  ScrollController controller = ScrollController();

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
    controller.addListener(() {
      if(controller.position.pixels == controller.position.maxScrollExtent) { /// 已经滑动到listView底部了
        if(widget.loadMore != null || isLoadingMore == false) {
          _loadMore();
        }
      } else if(controller.position.pixels == controller.position.minScrollExtent) {
        /// 滑动到顶部了，下拉刷新目前未实现
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  /// 构建SliverListView
  Widget _buildListView() {
    return ListView.builder(
      itemBuilder: widget.builder,
      itemCount: widget.itemCount,
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
    );
  }

  /// 构建SliverGridView
  Widget _buildGridView() {
    return GridView.builder(
      itemBuilder: widget.builder,
      itemCount: widget.itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount ??= 2,
        crossAxisSpacing: widget.crossAxisSpacing ??= 10,
        mainAxisSpacing: widget.mainAxisSpacing ??= 20,
        childAspectRatio: widget.childAspectRatio ??= 1
      ),
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
    );
  }

  /// 构建SliverPadding
  Widget _buildPadding(Widget child) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget._type == _LXListViewType.LIST_VIEW) {
      return _buildPadding(_buildListView());
    } else {
      return _buildPadding(_buildGridView());
    }
  }

}