import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/widget_util.dart';

typedef OnItemClick = void Function(int index);

class CircleSelector extends StatefulWidget {

  final List items;
  final Map<String, String> itemData;

  final OnItemClick itemClick;

  final Color largeCircleBackColor;
  final Color largeCircleTitleColor;
  final Color largeCircleDescColor;
  final Color smallCircleBackColor;
  final Color smallCircleIconColor;

  CircleSelector({
    Key key,
    @required this.items,
    @required this.itemData,
    this.itemClick,
    this.largeCircleBackColor = Colors.blue,
    this.largeCircleTitleColor = Colors.white,
    this.largeCircleDescColor = Colors.white70,
    this.smallCircleBackColor = Colors.blueAccent,
    this.smallCircleIconColor = Colors.white,
  }) : assert(items.length > 0 || items.length <= 5),
        assert(items.length == itemData.length),
        super(key: key);

  @override
  State<StatefulWidget> createState() => CircleSelectorState();

}

class CircleSelectorState extends State<CircleSelector> with TickerProviderStateMixin {

  /// 大圆里面的标题文字和描述文字
  String title, desc;

  double largeCircleMargin; /// 大圆的外边距
  double largeCircleDiameter; /// 大圆的直径
  double largeCircleCenter; /// 大圆的圆心坐标，x轴与y轴相同
  double smallCircleRadius; /// 小圆按钮的半径

  double tmpRectSize; /// 右下方隐藏的正方形边长，用于辅助

  double backCircleRadius; /// 小圆按钮圆心所在边界的圆的半径

  List angles = []; /// 所有的角度

  int currentIndex = 0; /// 当前选择的按钮索引
  int historyIndex = 0; /// 上一个按钮索引

  /// 动画和控制器
  Animation animation, animation2, animation3, animation4;
  CurvedAnimation curvedAnimation;
  Tween tween, tween2;
  AnimationController animationController, animationController2;

  @override
  void initState() {
    super.initState();

    title = widget.itemData.keys.elementAt(0);
    desc = widget.itemData.values.elementAt(0);

    largeCircleMargin = 20;
    largeCircleDiameter = WidgetUtil.getScreenWidth() / 2;
    largeCircleCenter = largeCircleDiameter / 2 + largeCircleMargin;
    smallCircleRadius = largeCircleDiameter / 3 / 2;

    tmpRectSize = WidgetUtil.getScreenWidth() - largeCircleCenter;

    backCircleRadius = largeCircleDiameter / 2 + (tmpRectSize - largeCircleDiameter / 2) / 2;

    /// 根据item数量。添加对应的角度
    switch(widget.items.length) {
      case 1:
        angles.addAll([45]);
        break;
      case 2:
        angles.addAll([30, 60]);
        break;
      case 3:
        angles.addAll([15, 45, 75]);
        break;
      case 4:
        angles.addAll([0, 30, 60, 90]);
        break;
      case 5:
        angles.addAll([-15, 15, 45, 75, 105]);
        break;
    }

    /// 第一个动画，按钮点击的透明度渐变
    animationController = AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    /// 当前选择的按钮执行渐显
    animation = Tween(begin: 0.6, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        if(state == AnimationStatus.completed) {
          animationController2.forward();
        }
      });
    /// 上一个选择的按钮执行渐隐
    animation2 = Tween(begin: 1.0, end: 0.6).animate(animationController);

    /// 第二个动画，第一个动画完成后执行，非线性速度位移
    animationController2 = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    curvedAnimation = CurvedAnimation(parent: animationController2, curve: Curves.elasticIn);
    /// 计算默认第一个小圆按钮的圆心坐标
    Offset tmpPoint = Offset(largeCircleCenter + backCircleRadius * math.cos(angles[0] * math.pi / 180), largeCircleCenter + backCircleRadius * math.sin(angles[0] * math.pi / 180));
    /// x轴非线性动画
    tween = Tween(begin: tmpPoint.dx - smallCircleRadius, end: largeCircleCenter - smallCircleRadius);
    animation3 = tween.animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        if(state == AnimationStatus.completed) {
          animationController2.reverse();

          /// 可以不用setState
          title = widget.itemData.keys.elementAt(currentIndex);
          desc = widget.itemData.values.elementAt(currentIndex);

          if(widget.itemClick != null) {
            widget.itemClick(currentIndex);
          }
        }
      });
    /// y轴非线性动画
    tween2 = Tween(begin: tmpPoint.dy - smallCircleRadius, end: largeCircleCenter - smallCircleRadius);
    animation4 = tween2.animate(curvedAnimation);

    /// 启动第一个动画
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    animationController2.dispose();
  }

  /// 构建items
  List<Widget> _items() {
    List<Widget> widgets = [];

    for(int i = 0; i < widget.items.length; i ++) {
      /// 小圆左上角顶点坐标
      Offset smallCircle = Offset(largeCircleCenter + backCircleRadius * math.cos(angles[i] * math.pi / 180), largeCircleCenter + backCircleRadius * math.sin(angles[i] * math.pi / 180));

      widgets.add(Positioned(
        left: currentIndex == i ? animation3.value : smallCircle.dx - smallCircleRadius, /// 小圆按钮的中心坐标
        top: currentIndex == i ? animation4.value : smallCircle.dy - smallCircleRadius,
        child: GestureDetector(
          child: Opacity(
            opacity: currentIndex == i ? animation.value : historyIndex == i ? animation2.value : 0.6,
            child: Container(
              width: smallCircleRadius * 2, /// 小圆按钮的直径
              height: smallCircleRadius * 2,
              decoration: BoxDecoration(
                  color: widget.smallCircleBackColor,
                  borderRadius: BorderRadius.all(Radius.circular(255))
              ),
              child: Icon(widget.items[i], color: widget.smallCircleIconColor),
            ),
          ),
          onTap: () {
            if(currentIndex == i)
              return;

            /// 重置第一个动画
            animationController.reset();

            setState(() {
              historyIndex = currentIndex;
              currentIndex = i;

              /// 设置第二个动画的属性值
              tween.begin = smallCircle.dx - smallCircleRadius;
              tween2.begin = smallCircle.dy - smallCircleRadius;
            });

            /// 启动第一个动画
            animationController.forward();
          },
        ),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: WidgetUtil.getScreenWidth(),
      height: WidgetUtil.getScreenWidth(),
      child: Stack(
        children: <Widget>[
//          Container(
//            color: Colors.green,
//          ),
//          Positioned(
//            left: largeCircleCenter,
//            top: largeCircleCenter,
//            child: Container(
//              width: tmpRectSize,
//              height: tmpRectSize,
//              color: Colors.red,
//            ),
//          ),
          Positioned(
            left: largeCircleMargin,
            top: largeCircleMargin,
            child: Container(
              width: largeCircleDiameter,
              height: largeCircleDiameter,
              decoration: BoxDecoration(
                color: widget.largeCircleBackColor,
                borderRadius: BorderRadius.all(Radius.circular(255))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 22,
                          color: widget.largeCircleTitleColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      color: widget.largeCircleDescColor,
                      fontSize: 13
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: _items(),
          ),
        ],
      ),
    );
  }

}