import 'package:flutter/material.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/22 14:01
/// @Description: 防抖点击
class DoubleClick extends StatelessWidget {
  final GestureTapCallback? onTap;

  final GestureTapCallback? onDoubleTap;

  final Widget? child;

  final HitTestBehavior? behavior;

  final GestureLongPressCallback? onLongPress;

  final GestureTapUpCallback? onTapUp;

  DoubleClick(
      {Key? key,
      this.onTap,
      this.child,
      this.onDoubleTap,
      this.behavior = HitTestBehavior.opaque,
      this.onLongPress,
      this.onTapUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: onTap,
//      onDoubleTap: onDoubleTap != null ? onDoubleTap : (){},
      behavior: behavior,
      onLongPress: onLongPress,
      onTapUp: onTapUp,
    );
  }
}
