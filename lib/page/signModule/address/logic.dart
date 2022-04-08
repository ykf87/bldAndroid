import 'dart:async';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/sign_info_entity.dart';
import 'package:SDZ/event/refresh_signPage_event.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';

import 'state.dart';

class AddressLogic extends GetxController {
  final AddressState state = AddressState();

  bool isEnable = false;
  String feedBackContent = '';
  String phone = '';
  String area = '请选择所在区域';
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();


  void onTextChange() {
    if (phoneController.text.length > 0
        && nameController.text.length > 0
        && addressController.text.length > 0
        && !area.contains("请选择所在区域")) {
      isEnable = true;
    } else {
      isEnable = false;
    }
    update();
  }
  void submitGift(int id) {
    Map<String, dynamic> map = Map();
    map['id'] =  id;
    map['name'] =  nameController.text;
    map['phone'] =  phoneController.text;
    map['address'] = area+addressController.text;
    map['remark'] =  remarkController.text;
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.giveget,data: map, isJTK: false, onSuccess: (data) {
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);

        ToastUtils.toast("提交成功");
        EventBusUtils.getInstance().fire(RefreshSignPageEvent());
        Get.back();

    }, onError: (msg) {
      ToastUtils.toast(msg);
    });
  }

  void selAddress(BuildContext context){
    Pickers.showAddressPicker(context,
        addAllItem:false,
        initProvince: '福建省',
        initCity: '福州市',
        initTown: '仓山区',
        pickerStyle: customizeStyle('选择地址'),
        onConfirm: (province,city,town){
          area = province+city+town!;
          onTextChange();
          update();
    });
  }

  //自定义选择地区样式
  PickerStyle customizeStyle(String title) {
    return PickerStyle(
      headDecoration: headDecoration,
      backgroundColor: Colours.bg_ffffff,
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Colours.text_333333, fontSize: 18),
        ),
      ),
      textColor: Colours.text_333333,
      commitButton: Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text('确定',
            style: TextStyle(color: Colours.dark_app_main, fontSize: 16)),
      ),
      cancelButton: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text('取消',
            style: TextStyle(color: Colours.text_333333, fontSize: 16)),
      ),
    );
  }

  // 头部样式
  Decoration headDecoration = BoxDecoration(
      color: Colours.bg_ffffff,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)));
}
