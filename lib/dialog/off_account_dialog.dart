import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/res/colors.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/6 10:17
/// @Description: 

class OffAccountDialog extends BaseDialog {

  final Function? onTap;

  final Function? onCancel;

  OffAccountDialog({Key? key, this.onTap, this.onCancel});

  @override
  BaseDialogState<BaseDialog> getState() => _OffAccountState();

}

class _OffAccountState extends BaseDialogState<OffAccountDialog> {

  @override
  Color color() => Colours.color_181A23;

  @override
  double radius() => 12;

  @override
  Widget initBuild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 28),
          child: Center(child: Text('账号已注销', style: TextStyle(color: Colors.white, fontSize: 18),),),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Text('该手机号已申请注销账号，若您继续登录，示为您放弃账号注销，原账号信息将保留继续使用。', style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
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
                  child: Text("取消", style: TextStyle(color: Colors.white, fontSize: 16),),
                  onPressed:(){
                    Navigator.pop(context);
                    widget.onCancel?.call();
                  },
                ),
              ), flex: 1,),
              Expanded(child: Container(
                decoration: BoxDecoration(
                    border: Border(top:BorderSide(color: Colours.color_292C39,width: 0.5))
                ),
                child: TextButton(
                  child: Text("继续登录", style: TextStyle(color: Colours.color_FF193C, fontSize: 16),),
                  onPressed:(){
                    Navigator.pop(context);
                    widget.onTap?.call();
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