
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';

import 'double_click.dart';

/// example
/// RequiredTextFieldController _requiredTextFieldController = new RequiredTextFieldController();
/// RequiredTextField(
///             isRequired: true,
///             text: '必须设置项',
///             isRequiredStart: true,
///             requiredText: '* ',
///             textStyle: TextStyle(color: HexColor('#717888'), fontSize: 14),
///             hintText: '需要多长时间完成',
///             hintTextStyle: TextStyle(color: HexColor('#BABDC7'), fontSize: 18),
///             isShowBottomLine: true,
///             enabled: false,
///             textFieldDefaultText: testTxt,
///             controller: _requiredTextFieldController,
///             onTap: () {
///               _requiredTextFieldController.setText(''); 动态更新
///             },
///           )

class RequiredTextFieldController extends ChangeNotifier {

  String _text = '';

  String get text => _text;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }
}

// ignore: must_be_immutable
class RequiredTextField extends StatefulWidget {

  /// 是否必填项
  final bool? isRequired;

  /// 必填项是否在前面
  final bool isRequiredStart;

  /// 必填项提示文字
  String requiredText;

  /// 必填项提示文字样式
  final TextStyle requiredStyle;

  /// 提示内容
  final String? text;

  /// 输入框内容(默认值)
  final String? textFieldDefaultText;

  /// 提示文字样式
  final TextStyle? textStyle;

  /// 输入框样式
  final InputDecoration? decoration;

  /// 输入框文字样式
  final TextStyle textFieldStyle;

  /// 输入框提示文本
  final String? hintText;

  /// 输入框提示文本样式
  final TextStyle? hintTextStyle;

  /// 清除icon
  final Icon cancelIcon;

  /// 是否显示底部线条
  final bool isShowBottomLine;

  /// 底部线条颜色
  final Color bottomLieColor;

  /// 输入框外边距
  final EdgeInsets textFieldMargin;

  /// 键盘类型
  final TextInputType keyboardType;

  /// 是否可编辑
  final bool enabled;

  /// 右箭头icon
  final Icon arrowIcon;

  /// 事件回调
  final Function? onTap;

  /// 右侧icon内边距
  final EdgeInsets rightIconPadding;
  
  /// 是否显示右侧icon(只对不可编辑有效)
  final bool isShowRightIcon;

  final RequiredTextFieldController? controller;

  RequiredTextField(
      {
        Key? key,
        this.controller,
        this.isRequired,
        this.isRequiredStart = true,
        this.requiredText = '* ',
        this.requiredStyle = const TextStyle(color: Colors.red, fontSize: 12),
        this.text,
        this.textStyle,
        this.decoration,
        this.hintText,
        this.hintTextStyle,
        this.cancelIcon = const Icon(Icons.cancel, color: Colors.grey, size: 20,),
        this.isShowBottomLine = true,
        this.bottomLieColor = Colours.color_E7EAED,
        this.textFieldMargin = const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
        this.keyboardType = TextInputType.text,
        this.enabled = true,
        this.textFieldStyle = const TextStyle(color: Colors.black, fontSize: 18),
        this.arrowIcon = const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20,),
        this.onTap,
        this.textFieldDefaultText,
        this.rightIconPadding = const EdgeInsets.only(top: 4),
        this.isShowRightIcon = false
      });

  @override
  _RequiredTextFieldState createState() => _RequiredTextFieldState();
}

class _RequiredTextFieldState extends State<RequiredTextField> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.textFieldDefaultText);
    widget.controller!.addListener(() {
      _controller.text = widget.controller!.text;
      setState(() {

      });
    });
    if(!widget.isRequiredStart && widget.requiredText.isNotEmpty) {
      widget.requiredText = ' *';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.isRequiredStart ? widget.requiredText : widget.text,
              style: widget.isRequiredStart ? widget.requiredStyle : widget.textStyle,
              children: [
                TextSpan(
                  text: widget.isRequiredStart ? widget.text : widget.requiredText,
                  style: widget.isRequiredStart ? widget.textStyle : widget.requiredStyle
                )
              ]
            ),
          ),
          Container(
            margin: widget.textFieldMargin,
            child: widget.enabled ? inputTextField() : noInputTextField(),
          ),
          widget.isShowBottomLine ? Divider(
            color: widget.bottomLieColor,
            height: 0.5,
          ) : Container()
        ],
      ),
    );
  }

  /// 可编辑
  Widget inputTextField() {
    return TextField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      onChanged: (text) {
        setState(() {
        });
      },
      style: widget.textFieldStyle,
      decoration: widget.decoration == null ? InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          border: InputBorder.none,
          suffixIcon: _controller.text.length > 0 ? DoubleClick(
            onTap: () {
              _controller.clear();
              setState(() {
              });
            },
            child: Padding(
              padding: widget.rightIconPadding,
              child: widget.cancelIcon,
            )
          ) : null
      ) : widget.decoration,
    );
  }

  /// 不可编辑
  Widget noInputTextField() {
    return DoubleClick(
      onTap: () {
        if(widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: widget.isShowRightIcon ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: isEnabledTextField(),
          ),
          Padding(
            padding: widget.rightIconPadding,
            child: widget.arrowIcon,
          )
        ],
      ) : isEnabledTextField()
    );
  }

  /// 不可编辑textField
  Widget isEnabledTextField() {
    return TextField(
      controller: _controller,
      readOnly: true,
      enabled: false,
      style: widget.textFieldStyle,
      decoration: widget.decoration == null ? InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle,
        border: InputBorder.none,
      ) : widget.decoration,
    );
  }
}