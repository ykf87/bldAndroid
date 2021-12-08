import 'package:flutter/material.dart';

/// 空AppBar
/// 需在Scaffold配置primary: false,
class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}