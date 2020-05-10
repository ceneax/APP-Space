import 'dart:async';

import 'package:flutter/material.dart';

typedef void OnBannerItemClick(int pos, String imgUrl);

class MyBanner extends StatefulWidget {

  final List<dynamic> data;
  final headers;
  final OnBannerItemClick itemClick;

  MyBanner(this.data, {Key key, this.headers, this.itemClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyBannerState();

}

class MyBannerState extends State<MyBanner> {

  PageController pageController;
  Timer timer;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    timer = Timer.periodic(Duration(milliseconds: 3000), (_) {
      if(pageController != null && widget.data.length > 0 && pageController.page != null) {
        if(pageController.page.toInt() == widget.data.length - 1) {
          pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
        } else {
          pageController.animateToPage(pageController.page.toInt() + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    timer.cancel();
  }

  /// onPageChanged事件
  void onPageChanged(index) {
  }

  /// 返回PageView
  Widget _getPageView() {
    return PageView.builder(
        onPageChanged: onPageChanged,
        controller: pageController,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(widget.data[index], fit: BoxFit.cover, headers: widget.headers),
            onTap: () {
              widget.itemClick(index, widget.data[index]);
            },
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getPageView(),
    );
  }

}