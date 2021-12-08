import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/styles.dart';

import 'base_dialog.dart';

class CancellationTipsDialog extends StatefulWidget {
  final Function() onPressed;
  String content;
  Widget? title;

  CancellationTipsDialog(
      {Key? key, required this.onPressed, this.title, required this.content})
      : super(key: key);

  @override
  _CancellationTipsDialog createState() => _CancellationTipsDialog();
}

class _CancellationTipsDialog extends State<CancellationTipsDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title ?? title(),
      showOneBtn: true,
      confirmTitle: '我知道了',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(widget.content,
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
      ),
      onPressed: () {
        Navigator.pop(context);
        widget.onPressed.call();
      },
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            "assets/svg/ic_warn.svg",
          ),
        ),
        SizedBox(width: 8),
        Text('警告',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
      ],
    );
  }
}
