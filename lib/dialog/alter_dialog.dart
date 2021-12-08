import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/res/colors.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/7 15:20
/// @Description: 
class AlterDialog extends BaseDialog{

  final String? title;

  final String? content;

  final String? cancelText;

  final String? confirmText;

  final Function? onTap;

  AlterDialog({this.title = '', this.content = '', this.cancelText = '取消', this.confirmText = '确定', this.onTap});

  @override
  BaseDialogState<BaseDialog> getState() => _AlterDialogState();

}

class _AlterDialogState extends BaseDialogState<AlterDialog> {
  @override
  Color color() => Colours.color_181A23;

  @override
  double radius() => 12;

  @override
  Widget initBuild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title!.isNotEmpty ? Container(
          margin: const EdgeInsets.only(top: 28),
          child: Center(child: Text(widget.title!, style: TextStyle(color: Colors.white, fontSize: 18),),),
        ) : Container(),
        widget.content!.isNotEmpty ? Container(
          margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Text(widget.content!, style: TextStyle(color: Colors.white, fontSize: 14)),
        ) : Container(),
        Container(
          margin: const EdgeInsets.only(top: 28),
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colours.color_292C39, width: 0.5),top:BorderSide(color: Colours.color_292C39,width: 0.5))
                ),
                child: TextButton(
                  child: Text(widget.cancelText!, style: TextStyle(color: Colors.white, fontSize: 16),),
                  onPressed:(){
                    Navigator.pop(context);
                    widget.onTap?.call(0);
                  },
                ),
              ), flex: 1,),
              Expanded(child: Container(
                decoration: BoxDecoration(
                    border: Border(top:BorderSide(color: Colours.color_292C39,width: 0.5))
                ),
                child: TextButton(
                  child: Text(widget.confirmText!, style: TextStyle(color: Colours.color_FF193C, fontSize: 16),),
                  onPressed:(){
                    Navigator.pop(context);
                    widget.onTap?.call(1);
                  },
                ),
              ),flex: 1,)
            ],
          ),
        )
      ],
    );
  }

}