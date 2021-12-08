import 'package:flutter/material.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/widget/double_click.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/7 9:16
/// @Description: 蒙版引导

class MaskGuideDialog extends BaseDialog {
  @override
  BaseDialogState<BaseDialog> getState() => _MaskGuideDialog();
}

class _MaskGuideDialog extends BaseDialogState<MaskGuideDialog> {

  bool _isNext = false;

  @override
  Color color() => Colors.transparent;

  @override
  double radius() => 0;

  @override
  double maxWidth() => MediaQuery.of(context).size.width;

  @override
  Widget initBuild(BuildContext context) {
    return DoubleClick(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(_isNext){
          Navigator.of(context).pop();
        }else{
          _isNext = true;
          setState(() {

          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(_isNext ? 'assets/images/img_guide_1.png' : 'assets/images/img_guide.png', width: _isNext ? MediaQuery.of(context).size.width/5 * 4 : MediaQuery.of(context).size.width/3 * 2, fit: BoxFit.cover,),
              Container(
                margin: const EdgeInsets.only(top: 60),
                width: 96,
                height: 36,
                child: _isNext ? Container() : OutlinedButton(
                  onPressed: (){
                    _isNext = true;
                    setState(() {

                    });
                  },
                  child: Text('下一步', style: TextStyle(color: Colors.white, fontSize: 14),),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Colors.white,
                          width: 0.5
                      ))
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}