import 'package:flutter/material.dart';
import 'package:SDZ/utils/wf_log_util.dart';

///标签
class TagFlowDelegate extends FlowDelegate {
  //只有多行时才生效
  EdgeInsets margin = EdgeInsets.zero;
  int lineCout = 1;
  double flowHeight = 30; //一行标签高度
  double allChildWidth = 0;
  int curLine = 1;

  TagFlowDelegate({required this.margin,
    required this.lineCout,
    required this.flowHeight,
    required this.allChildWidth});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = 0.0;
    var y = margin.top;
    //省略号的宽
    double lastW = context.getChildSize(context.childCount - 1)!.width +
        margin.right +
        margin.left;
    int lastIndex = context.childCount - 1;

    curLine = 1;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount - 1; i++) {
      //当前项的宽
      var curW = context.getChildSize(i)!.width + margin.right + margin.left;
      if (x + curW > context.size.width) {
        //剩余空间不够显示当前标签
        if (curLine == lineCout) {
          //已经是最后一行，直接paint最后1个省略号
          context.paintChild(context.childCount - 1,
              transform: new Matrix4.translationValues(x, y, 0.0));
          break;
        } else {
          //换下一行，
          curLine++;
          x = 0;
          y = y + margin.bottom + context.getChildSize(i)!.height;
          context.paintChild(i,
              transform: new Matrix4.translationValues(x, y, 0.0));
          x = x + curW;
        }
      } else {
        //剩余空间够显示当前项
        if ((x + curW + lastW > context.size.width) &&
            (lineCout == curLine) &&
            (i < lastIndex - 1)) {
          //剩余空间不够显示当前项+省略号 且 是最后一行 且当前项不是最后一项标签，
          // 则不paint当前项，直paint最后的省略号项
          context.paintChild(context.childCount - 1,
              transform: new Matrix4.translationValues(x, y, 0.0));
          break;
        } else {
          //剩余空间够显示当前项+省略号,直接paint在当前项
          context.paintChild(i,
              transform: new Matrix4.translationValues(x, y, 0.0));
          //下一项的x
          x = x + curW;
        }
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    double height = constraints.maxWidth < allChildWidth
        ? (lineCout * flowHeight +
        (margin.top + margin.bottom) * (lineCout - 1))
        : flowHeight;
    WFLogUtil.v("---------flowHeight-----------" + flowHeight.toString());
    WFLogUtil.v("---------height-----------" + height.toString());
    return Size(double.infinity, height);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
