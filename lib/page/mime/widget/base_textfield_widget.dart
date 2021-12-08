import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';

///标题 + 输入框
class BaseTextfieldWidget extends StatelessWidget {
  final String? hintText;
  final String title;
  final int? maxLength;
  final bool enable; //是否可标记

  final GestureTapCallback? onTap;
  final TextEditingController controller;
  final TextInputType? inputType;

  const BaseTextfieldWidget(
      {Key? key,
      this.hintText,
      this.maxLength,
      this.onTap,
      this.enable = true,
      required this.title,
      this.inputType,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleClick(
      child: Column(
        children: [
          SizedBox(
            height: 28,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(color: Colours.text_main, fontSize: 14)),
                  SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colours.text_main,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                        maxLength: maxLength,
                        maxLines: 1,
                        enabled: enable,
                        controller: controller,
                        keyboardType: inputType ?? TextInputType.text,
                        decoration: InputDecoration(
                            counterText: "", // 此处控制最大字符是否显示
                            hintText: hintText ?? '',
                            hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                            border: InputBorder.none,
                            suffixIcon: controller.text.length > 0 && enable
                                ? IconButton(
                                    iconSize: 20,
                                    icon: Icon(Icons.cancel),
                                    color: Colors.grey,
                                    onPressed: () {},
                                  )
                                : Text('')),
                      ),
                    ),
                  ],
                ),
                height: 48.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: Colours.dark_bg_color2,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
