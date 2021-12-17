import 'package:SDZ/core/widget/loading_dialog.dart';
import 'package:SDZ/res/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// @class : GetExtension
/// @date : 2021/08/18
/// @name : jhf
/// @description :get 扩展方法
extension GetExtension on GetInterface {
  ///隐藏dialog
  dismiss() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
  }

  ///显示dialog
  showLoading({String text = ''}) {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }

  }


}
