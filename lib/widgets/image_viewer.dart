import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {

  List images;
  int index;
  var header;

  ImageViewer({Key key, @required this.images, this.index = 1, this.header}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();

}

class _ImageViewerState extends State<ImageViewer> {

  int currentIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                  child: PhotoViewGallery.builder(
//                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(widget.images[index], headers: widget.header),
                      );
                    },
                    itemCount: widget.images.length,
                    backgroundDecoration: null,
                    pageController: pageController,
                    enableRotation: true,
                    onPageChanged: (index){
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  )
              ),
            ),
            Positioned( /// 图片index显示
              top: MediaQuery.of(context).padding.top + 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('${currentIndex + 1}/${widget.images.length}',style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
//          Positioned( /// 右上角关闭按钮
//            right: 10,
//            top: MediaQuery.of(context).padding.top,
//            child: IconButton(
//              icon: Icon(Icons.close,size: 30,color: Colors.white,),
//              onPressed: (){
//                Navigator.of(context).pop();
//              },
//            ),
//          ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

}