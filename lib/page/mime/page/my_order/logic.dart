import 'package:SDZ/page/mime/entity/order_entity.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/base/base_entity.dart';

import 'state.dart';

class MyOrderLogic extends GetxController {
  final state = MyOrderState();

  void getData() {
    Map<String, dynamic> map = new Map();
    map['page'] = state.pageNum;
    map['limit'] = 30;
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl()+ApiUrl.orderList, data: map,isJTK: false, onSuccess: (data) {
      BaseEntity<OrderEntity> entity =
      BaseEntity.fromJson(data!);
      if(entity.isSuccess && entity.data != null){
        List<OrderList>? list = entity.data?.list;
        state.refreshController.finishLoad(noMore: list!.length < 30);
        state.refreshController.finishRefresh(success: true);
        state.list.addAll(list);
        state.isShowEmpty = state.list.length== 0;
      }else{
        state.isShowEmpty = state.list.length== 0;
      }
      update();
    }, onError: (msg) {
      state.isShowEmpty = state.list.length== 0;
      state.refreshController.finishLoad(noMore: true);
      state.refreshController.finishRefresh(success: true);
      if (state.pageNum > 1) {
        state.pageNum--;
      }
      update();
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
