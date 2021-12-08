import 'package:flutter/material.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 9:44
/// @Description:

abstract class BaseDialog extends StatefulWidget {

  BaseDialog({Key? key}): super(key: key);

  @override
  BaseDialogState createState()=> getState();

  BaseDialogState getState();

}

abstract class BaseDialogState<T extends BaseDialog> extends State<T> {

  /// dialog 自定义布局
  Widget initBuild(BuildContext context);

  /// dialog 背景色
  Color color() => Colors.white;

  /// dialog 圆角
  double radius() => 6.0;

  /// dialog 最大宽度
  double maxWidth() => MediaQuery.of(context).size.width * 0.8;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      ///Material 是为了解决字体 不然text会带有黄色下划线
      child: Material(
        color: color(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius())),
          side: BorderSide.none
        ),
        child: Container(
          width: maxWidth(),
          decoration: BoxDecoration(
            color: color(),
            borderRadius: BorderRadius.all(Radius.circular(radius())),
          ),
          child: initBuild(context),
        ),
      ),
    );
  }
}