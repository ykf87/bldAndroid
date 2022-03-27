import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
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

  void onTextChange() {
    if (feedBackContent.length > 0 && phone.length > 0) {
      isEnable = true;
    } else {
      isEnable = false;
    }
    update();
  }
  void submitGift(String content,String phone) {
    ToastUtils.toast("提交成功");
    feedBackContent ='';
    Get.back();
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
