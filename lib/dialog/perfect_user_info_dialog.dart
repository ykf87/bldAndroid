import 'package:flutter/material.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/res/colors.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/25 14:30
/// @Description: 完善信息跳过弹窗 
class PerfectUserInfoDialog extends BaseDialog {
  
  final Function onTap;
  
  PerfectUserInfoDialog({Key? key, required this.onTap});
  
  @override
  BaseDialogState<BaseDialog> getState() => _PerfectUserInfoState();
}

class _PerfectUserInfoState extends BaseDialogState<PerfectUserInfoDialog> {

  @override
  Widget initBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('温馨提示', style: TextStyle(fontSize: 16),),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Text('跳过后，您可以在我的资料中继续完善个人信息', textAlign: TextAlign.center, style: TextStyle(color: Colours.text_131313, fontSize: 14),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 80,
                  child: OutlinedButton(
                    onPressed: () {
                      if(widget.onTap != null) {
                        widget.onTap.call();
                      }
                    },
                    child: Text('跳过', style: TextStyle(color: Colours.text_131313, fontSize: 14)),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                      ),
                      child: Text(
                        '继续完善资料', style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
}