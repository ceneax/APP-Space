import 'dart:io';

import 'package:flutter/material.dart';

typedef void OnItemClick(int pos, File currentUrl, List<File> urlList);
typedef void OnItemClose(int pos, File currentUrl, List<File> urlList);

class LocalNineGridImage extends StatelessWidget {

  final List<File> urlList;
  OnItemClick itemClick;
  OnItemClose itemClose;

  LocalNineGridImage(this.urlList, {Key key, this.itemClick, this.itemClose}) : super(key: key);

  /// 返回不同类型的SliverGridDelegateWithFixedCrossAxisCount
  SliverGridDelegateWithFixedCrossAxisCount _getGridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 横轴元素个数
        mainAxisSpacing: 5, // 纵轴间距
        crossAxisSpacing: 5, // 横轴间距
        childAspectRatio: 1 // 子组件宽高长度比例
    );
  }

  /// 返回item
  Widget _getGridItem(int index) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(urlList[index])
            )
        ),
        child: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            if(itemClose != null)
              itemClose(index, urlList[index], urlList);
          },
        ),
      ),
      onTap: () {
        if(itemClick != null)
          itemClick(index, urlList[index], urlList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if(urlList.length <= 0)
      return Container();

    return GridView.builder(
      /// =========================
      /// 这两行属性是listview嵌套gridview时需要的，第一个如果不加，就需要在gridview.builder外面指定宽高；第二行属性是禁止gridview滚动，解决滑动冲突
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      /// =========================
      itemCount: urlList.length,
      gridDelegate: _getGridDelegate(),
      itemBuilder: (context, index) {
        return _getGridItem(index);
      },
    );
  }

}