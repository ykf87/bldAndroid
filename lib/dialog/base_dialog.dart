import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/dimens.dart';
import 'package:SDZ/res/gaps.dart';
import 'package:SDZ/res/styles.dart';
import 'package:SDZ/utils/device_utils.dart';
import 'package:SDZ/utils/my_button.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {Key? key,
      this.title,
      required this.onPressed,
      this.hiddenTitle = false,
      this.showOneBtn = false,
      this.confirmTitle ,
      required this.child})
      : super(key: key);

  final Widget? title;
  final String? confirmTitle;
  final VoidCallback onPressed;
  final Widget child;
  final bool hiddenTitle;
  final bool showOneBtn;//只显示一个按钮

  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: title,
      ),
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        showOneBtn?SizedBox.shrink(): _DialogButton(
          text: '取消',
          textColor: Colours.bg_ffffff,
          onPressed: () => Get.back(),
        ),
        showOneBtn?SizedBox.shrink():const SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(color: Colours.color_dialog_line),
        ),
        _DialogButton(
          text: confirmTitle??'确定',
          textColor: Colours.color_main_red,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget content = Material(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap12,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    final Widget body = MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: SizedBox(
          width: 270.0,
          child: content,
        ),
      ),
    );

    /// Android 11添加了键盘弹出动画，这与我添加的过渡动画冲突（原先iOS、Android 没有相关过渡动画，相关问题跟踪：https://github.com/flutter/flutter/issues/19279）。
    /// 因为在Android 11上，viewInsets的值在键盘弹出过程中是变化的（以前只有开始结束的值）。
    /// 所以解决方法就是在Android 11及以上系统中使用Padding代替AnimatedPadding。

    if (Device.getAndroidSdkInt() >= 30) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: body,
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic, // easeOutQuad
        child: body,
      );
    }
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        text: text,
        fontSize: 16,
        textColor: textColor,
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
