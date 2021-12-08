import 'package:flutter/services.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/24 10:45
/// @Description: 自定义兼容中文拼音输入法正则校验输入框
class CustomTextInputFormatter extends TextInputFormatter {
  final Pattern filterPattern;

  CustomTextInputFormatter({required this.filterPattern})
      : assert(filterPattern != null);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.isComposingRangeValid) return newValue;
    return FilteringTextInputFormatter.allow(filterPattern)
        .formatEditUpdate(oldValue, newValue);
  }
}