import 'package:SDZ/page/mime/entity/my_order_entity.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/base/base_entity.dart';

import 'state.dart';

class MyOrderLogic extends GetxController {
  final state = MyOrderState();

  void getData() {
    EasyLoading.showToast('加载中...');
    Map<String, dynamic> map = new Map();
    map['page'] = state.pageNum;
    map['limit'] = 30;
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl()+ApiUrl.orderList, data: map,isJTK: false, onSuccess: (data) {
      BaseEntity<MyOrderEntity> entity =
      BaseEntity.fromJson(data!);
      if(entity.isSuccess && entity.data != null){
        List<MyOrderList>? list = entity.data?.xList;
        state.refreshController.finishLoad(noMore: list!.length < 30);
        state.refreshController.finishRefresh(success: true);
        state.list.addAll(list);
        state.isShowEmpty = state.list.length== 0;
      }else{
        state.isShowEmpty = state.list.length== 0;
      }
      update();
      EasyLoading.dismiss();
    }, onError: (msg) {
      state.isShowEmpty = state.list.length== 0;
      state.refreshController.finishLoad(noMore: true);
      state.refreshController.finishRefresh(success: true);
      if (state.pageNum > 1) {
        state.pageNum--;
      }
      update();
      EasyLoading.dismiss();
    });
  }

  void doRefresh() {
    state.list.clear();
    state.pageNum = 1;
    getData();
  }

  void doLoadMore() {
    state.pageNum++;
    getData();
  }
}
