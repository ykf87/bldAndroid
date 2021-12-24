import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/gaps.dart';
import 'package:SDZ/widget/double_click.dart';

///设置页面 文本框控件
class LineTextWidget extends StatefulWidget {
  final String? leftImg;
  final String leftText;
  final String rightText;
  final String rightIcon;
  final Color bgColor;
  final bool isRadius;
  final Function()? onPressed;

  const LineTextWidget(
      {Key? key,
      this.leftImg,
      this.leftText = '',
      this.rightText = '',
      this.rightIcon = '',
      this.isRadius = false,
      this.bgColor = Colours.dark_bg_color2,
      this.onPressed})
      : super(key: key);

  @override
  _LineTextWidgetState createState() => _LineTextWidgetState();
}

class _LineTextWidgetState extends State<LineTextWidget> {
  @override
  Widget build(BuildContext context) {
    return new DoubleClick(
      onTap: () {
        widget.onPressed?.call();
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(widget.isRadius ? 8.0 : 0),
        ),
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.leftImg == null
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(right: 14),
                    width: 20,
                    height: 20,
                    child:widget.leftImg!.endsWith('.svg')?SvgPicture.asset(
                      "assets/svg/${widget.leftImg}",
                    ):new Image.asset("assets/images/${widget.leftImg}",
                      width: 20.0,
                      height: 20.0,),
                  ),
            Text(widget.leftText,
                style: TextStyle(color: Colours.text_121212, fontSize: 15)),
            Gaps.hGap20,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.rightIcon == ''
                      ? SizedBox.shrink()
                      : Container(
                    margin: EdgeInsets.only(right: 8),
                    child: SvgPicture.asset('assets/svg/${widget.rightIcon}',height:22 ,width: 22),
                  ),
                  widget.rightText == ''
                      ? SizedBox.shrink()
                      : Text(
                          widget.rightText,
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(color: Colours.text_main, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                  SizedBox(
                    width: 12,
                  )
                ],
              ),
            ),
            Image(
              image: AssetImage("assets/images/ic_next.png"),
              width: 20,
              height: 20,
              color: Colours.color_black45,
            )
          ],
        ),
      ),
    );
  }
}
