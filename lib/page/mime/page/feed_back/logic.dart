import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/utils/sputils.dart';

import 'state.dart';

class Feed_backLogic extends GetxController {
  final state = Feed_backState();
  bool isEnable = false;
  String feedBackContent = '';
  String phone = '';
  TextEditingController phoneController = new TextEditingController();


  void onTextChange() {
    if (feedBackContent.length > 0 && phone.length > 0) {
      isEnable = true;
    } else {
      isEnable = false;
    }
    update();
  }

  void feedbak(String content,String phone) {
    Map<String, dynamic> map = new Map();
    map['content'] = content;
    map['telephone'] = phone;
    ApiClient.instance.post(ApiUrl.feedback, data: map, onSuccess: (data) {
      ToastUtils.toast("感谢您的反馈");
      feedBackContent ='';
      Get.back();
    });
  }

}
