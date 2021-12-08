
import 'package:flutter/material.dart';

/// 时间轴
class TimeLine extends StatefulWidget {

  /// 图标
  final Widget iconWidget;

  /// 右边内容
  final Widget contentWidget;

  /// 竖线宽度
  final double lineWidth;

  /// 竖线颜色
  final Color lineColor;

  /// 竖线顶部缩进
  final double lineIndent;

  /// 竖线尾部缩进
  final double lineEndIndent;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 主要用在图标与右边内容顶部对齐
  final double topMargin;

  /// 最后一条竖线是否显示(默认显示)
  final bool lastLineVisibility;

  /// 竖线高度
  final double lineHeight;

  TimeLine({Key? key,
    required this.contentWidget,
    this.iconWidget = const Icon(Icons.radio_button_unchecked_rounded, size: 8, color: Colors.grey,),
    this.lineWidth = 0.5,
    this.lineColor = Colors.grey,
    this.margin = EdgeInsets.zero,
    this.topMargin = 0,
    this.lineIndent = 10,
    this.lineEndIndent = 0,
    this.lastLineVisibility = true,
    this.lineHeight = -1});

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: widget.topMargin),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  widget.lineHeight == -1 ? VerticalDivider(
                    // width: widget.lineWidth,
                    thickness: widget.lineWidth,
                    color: widget.lastLineVisibility ? widget.lineColor : Colors.transparent,
                    indent: widget.lineIndent,
                    endIndent: widget.lineEndIndent,
                  ) : Container(
                    height: widget.lineHeight,
                    child: VerticalDivider(
                      // width: widget.lineWidth,
                      thickness: widget.lineWidth,
                      color: widget.lastLineVisibility ? widget.lineColor : Colors.transparent,
                      indent: widget.lineIndent,
                      endIndent: widget.lineEndIndent,
                    ),
                  ),
                  widget.iconWidget
                ],
              ),
            ),
            Expanded(
              child: widget.contentWidget,
            ),
          ],
        ),
      )
    );
  }
}