import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:SDZ/widget/double_click.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/2 13:46
/// @Description: 图文按钮
class TextImageButton extends StatefulWidget {

  /// 文本内容
  final String text;

  /// 文本样式
  final TextStyle? textStyle;

  /// 图标位置 0 左 1 上 2 右 3 下
  final int position;

  /// 图标类型 1 widget 2 url 3 svg
  final int iconType;

  /// 图标
  final Widget? icon;

  /// 图标url
  final String iconUrl;

  /// svg 路径
  final String svgPath;

  /// svg 颜色
  final Color? svgColor;

  /// 图标与文本间距
  final double margin;

  /// 点击回调
  final Function? onTap;

  /// 图标大小(针对iconUrl 设置)
  final Size size;

  /// 标识
  final dynamic flag;

  /// 是否拦截手势
  final bool interceptGesture;

  TextImageButton(
      {
        Key? key,
        this.text = '',
        this.textStyle = const TextStyle(color: Colors.black, fontSize: 14),
        this.position = 0,
        this.icon,
        this.iconUrl = '',
        this.margin = 3.0,
        this.size = const Size(30, 30),
        this.onTap,
        this.flag,
        this.iconType = 1,
        this.svgPath = '',
        this.svgColor,
        this.interceptGesture = false,
      }):super(key: key);

  @override
  State<StatefulWidget> createState() => _TextImageState();

}

class _TextImageState extends State<TextImageButton> {

  @override
  Widget build(BuildContext context) {
    return widget.interceptGesture ? getContainer() : DoubleClick(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if(widget.flag != null) {
          widget.onTap?.call(widget.flag!);
        }else{
          widget.onTap?.call();
        }
      },
      child: getContainer(),
    );
  }

  Widget getContainer() {
    Widget? wg;
    switch(widget.position) {
      case 0:
        wg = leftImage();
        break;
      case 1:
        wg = topImage();
        break;
      case 2:
        wg = rightImage();
        break;
      case 3:
        wg = bottomImage();
        break;
    }
    return wg!;
  }

  Widget topImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getIcon(),
        Container(
          margin: EdgeInsets.only(top: widget.margin),
          child: Text(widget.text, style: widget.textStyle!),
        )
      ],
    );
  }

  Widget leftImage() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        getIcon(),
        Container(
          margin: EdgeInsets.only(left: widget.margin),
          child: Text(widget.text, style: widget.textStyle!),
        )
      ],
    );
  }

  Widget rightImage() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.text, style: widget.textStyle!),
        Container(
          margin: EdgeInsets.only(left: widget.margin),
          child: getIcon(),
        )
      ],
    );
  }

  Widget bottomImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.text, style: widget.textStyle!),
        Container(
          margin: EdgeInsets.only(top: widget.margin),
          child: getIcon(),
        )
      ],
    );
  }

  Widget getIcon() {
    if(widget.iconType == 2 && widget.iconUrl.isNotEmpty) {
      return CachedNetworkImage(imageUrl: widget.iconUrl, width: widget.size.width, height: widget.size.height,);
    }
    if(widget.iconType == 3 && widget.svgPath.isNotEmpty) {
      return SvgPicture.asset(widget.svgPath, width: widget.size.width, height: widget.size.height,);
    }
    return widget.icon!;
  }
}