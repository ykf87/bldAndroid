import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignLogic extends GetxController {
  final state = SignState();

  void getGiftList() {
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['limit'] = 30;
    EasyLoading.showToast('加载中...');
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl()+ApiUrl.giftList, data: map, isJTK: false,
        onSuccess: (data) {
          EasyLoading.dismiss();
          BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);

          // if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
          //   state.list.addAll(entity.data?.list ?? []);
          // } else {
          // }
          update();
        }, onError: (msg) {
          EasyLoading.dismiss();
        });
  }

  void getData() {
    Map<String, dynamic> map = Map();
    map['pub_id'] = JtkApi.pub_id;
    map['source'] = 'taobao';
    // map['cat'] = pub_id;//分类
    // map['sub_share_rate'] = sub_share_rate;//分成比例 1代表100%，0.9代表90%，默认1
    map['page'] = 1;
    map['pageSize'] = 20;
    EasyLoading.showToast('加载中...');
    ApiClient.instance.get(ApiUrl.query_goods, data: map, isJTK: true,
        onSuccess: (data) {
          EasyLoading.dismiss();
          BaseEntity<List<GoodsEntity>> entity = BaseEntity.fromJson(data!);

          if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
            state.list.addAll(entity.data ?? []);
          } else {
          }
        update();
        }, onError: (msg) {
          EasyLoading.dismiss();
        });
  }


  ///选中签到奖品
  void commitGift() {
    ToastUtils.toast('已选择');
    Map<String, dynamic> map = Map();
    map['id'] = 1;
    EasyLoading.showToast('加载中...');
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl()+ApiUrl.giveget, data: map, isJTK: false,
        onSuccess: (data) {
          EasyLoading.dismiss();
          BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);

          // if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
          //   state.list.addAll(entity.data?.list ?? []);
          // } else {
          // }
          update();
        }, onError: (msg) {
          EasyLoading.dismiss();
        });
  }
}
