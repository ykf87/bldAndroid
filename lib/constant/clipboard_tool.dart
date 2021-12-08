import 'package:flutter/services.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/utils/wf_log_util.dart';

//复制粘贴
class ClipboardTool {
  //复制内容
  static setData(String data) {
    if (data != null && data != '') {
      WFLogUtil.d("--------Clipboard.setData---------");
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //复制内容
  static setDataToast(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtils.toast('复制成功');
    }
  }

  //复制内容
  static setDataToastMsg(String data, {String toastMsg = '复制成功'}) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtils.toast(toastMsg);
    }
  }

  //获取内容
  // static Future<ClipboardData>? getData() {
  //   return Clipboard.getData(Clipboard.kTextPlain);
  // }

//将内容复制系统
//   ClipboardUtil.setData('123');
//从系统获取内容
//   ClipboardUtil.getData().then((data){}).catchError((e){});

}
