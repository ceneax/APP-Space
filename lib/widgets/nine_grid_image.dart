import 'package:flutter/material.dart';

typedef void OnItemClick(int pos, String currentUrl, var urlList);

class NineGridImage extends StatelessWidget {

  var urlList;
  OnItemClick itemClick;
  var header;

  NineGridImage(this.urlList, {Key key, this.itemClick, this.header}) : super(key: key);

  /// 返回不同类型的SliverGridDelegateWithFixedCrossAxisCount
  SliverGridDelegateWithFixedCrossAxisCount _getGridDelegate() {
    int dataLength = urlList.length;

    int crossAxisCount = 1; /// 横轴元素个数
    double mainAxisSpacing = 5; /// 纵轴间距
    double crossAxisSpacing = 5; /// 横轴间距
    double childAspectRatio = 1; /// 子组件宽高长度比例

    if(dataLength == 1) {
      childAspectRatio = 2;
    }
    if(dataLength == 1 || dataLength == 2 || dataLength == 3) {
      crossAxisCount = dataLength;
    } else if(dataLength == 4) {
      crossAxisCount = 2;
    } else if(dataLength >= 5) {
      crossAxisCount = 3;
    }

    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio
    );
  }

  /// 返回item
  Widget _getGridItem(int index) {
    var item;
    int dataLength = urlList.length;

    item = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlList[index], headers: header)
            )
        ),
      ),
      onTap: () {
        if(itemClick != null)
          itemClick(index, urlList[index], urlList);
      },
    );

    if(dataLength > 9) {
      if(index == 8) {
        item = GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(urlList[index], headers: header)
                )
            ),
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/widget_nine_grid_image_more.png')
                )
            ),
          ),
          onTap: () {
            if(itemClick != null)
              itemClick(index, urlList[index],urlList);
          },
        );
      }
    }

    return item;
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
      itemCount: urlList.length > 9 ? 9 : urlList.length,
      gridDelegate: _getGridDelegate(),
      itemBuilder: (context, index) {
        return _getGridItem(index);
      },
    );
  }

}