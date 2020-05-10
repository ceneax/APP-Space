import 'package:flutter/material.dart';

class AppBarCorner extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize = Size.fromHeight(20);

  final Color color;

  AppBarCorner({
    @required this.color,
    Key key,
  }) : assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
    );
  }

}