import 'package:flutter/material.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/19 9:40
/// @Description: 自定义页面切换动画
class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  CustomRoute(this.widget):
      super(transitionDuration:Duration(milliseconds: 300), pageBuilder:(
  BuildContext context,
      Animation<double> animation1,
  Animation<double> animation2,
  ){
  return widget;
  },
  transitionsBuilder:(BuildContext context,
      Animation<double> animation1,
  Animation<double> animation2,
      Widget child,
  ){
    return SlideTransition(
      position: Tween<Offset>(
          begin: Offset(1.0,0.0),
          end: Offset(0.0, 0.0)
      ).animate(CurvedAnimation(
          parent: animation1,
          curve: Curves.fastOutSlowIn
      )),
      child: child,
    );
  }
      );
}