import 'package:SDZ/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/styles.dart';

import 'base_dialog.dart';

class ExitDialog extends StatefulWidget {
  final Function() onPressed;
  String content;
   ExitDialog({
    Key? key,
     required this.onPressed,
     required this.content
  }) : super(key: key);

  @override
  _ExitDialog createState() => _ExitDialog();
}

class _ExitDialog extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      hiddenTitle: true,
      child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(widget.content, style: TextStyle(color: Colours.text_121212,fontSize: 16)),
      ),
      onPressed: () {
        Navigator.pop(context);
        widget.onPressed.call();
      },
    );
  }
}
