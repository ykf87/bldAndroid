import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'common_widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final VoidCallback? onTap;

  CustomAppBar({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBar(title ?? "", onTap),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(ScreenUtil.getInstance().appBarHeight);
}
