import 'package:flutter/material.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/utils/jpush_util.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/26 16:43
/// @Description: 通知权限申请弹窗

class NotificationPermissionDialog extends BaseDialog {
  @override
  BaseDialogState<BaseDialog> getState() => _NotificationPermissionState();

}

class _NotificationPermissionState extends BaseDialogState<NotificationPermissionDialog> {
  @override
  Widget initBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('是否打开通知'),
          Row(
            children: [
              Container(
                width: 80,
                margin: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消', style: TextStyle(fontSize: 14),),
                ),
              ),
              Expanded(child: TextButton(onPressed: () {
                Navigator.of(context).pop();
                JPushUtil().openSettingNotification();
              }, child: Text('打开', style: TextStyle(fontSize: 14),)))
            ],
          )
        ],
      ),
    );
  }

}