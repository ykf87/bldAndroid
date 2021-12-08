import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';

import 'state.dart';

class Browse_recordsLogic extends GetxController {
  final state = Browse_recordsState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getData() {
    Map<String, dynamic> map = new Map();
    map['pageNum'] = state.pageNum;
    ApiClient.instance.get(ApiUrl.history, data: map, onSuccess: (data) {
      BaseEntity<List<MyBrowseRecordEntity>> entity =
          BaseEntity.fromJson(data!);
      if(entity.isSuccess && entity.data != null){
        List<MyBrowseRecordEntity>? list = entity.data;
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
