import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';

import 'state.dart';

class My_collectLogic extends GetxController {
  final state = My_collectState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    EventBusUtils.getInstance().fire(UserCenterEvent()); //刷新个人中心数据
    state.userCenterEventBus = EventBusUtils.getInstance().on<UserCenterEvent>().listen((event) {
      doRefresh();
    });
  }

  void cancleCollect(int index) {
    ApiClient.instance
        .delete('${ApiUrl.collection}/${state.list[index].cardId}',
            onSuccess: (data) {
      state.list.removeAt(index);
      state.isShowEmpty = state.list.length == 0;
      EventBusUtils.getInstance().fire(UserCenterEvent()); //刷新个人中心数据
      update();
    }, onError: (msg) {
      ToastUtils.toast(msg);
      WFLogUtil.d('msg==$msg');
    });
  }

  void doRefresh() {
    state.pageNum = 1;
    state.list.clear();
    getData();
  }

  void doLoadMore() {
    state.pageNum++;
    getData();
  }

  void getData() {
    Map<String, dynamic> map = new Map();
    map['pageNum'] = state.pageNum;
    ApiClient.instance.get(ApiUrl.collections, data: map, onSuccess: (data) {
      BaseEntity<List<MyCollectEntity>> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess && entity.data != null){
        if(state.pageNum == 1){
          state.list.clear();
        }
        List<MyCollectEntity>? list = entity.data;
        state.refreshController.finishLoad(noMore: list!.length < 30);
        state.list.addAll(list);
        state.refreshController.finishLoad(noMore: list.length < 30);
        state.refreshController.finishRefresh(success: true);
      }
      state.isShowEmpty = state.list.length == 0;
      update();
    }, onError: (msg) {
      state.isShowEmpty = state.list.length == 0;
      state.refreshController.finishLoad(noMore: true);
      state.refreshController.finishRefresh(success: false);
      if (state.pageNum > 1) {
        state.pageNum--;
      }
      update();
    });
  }
}
