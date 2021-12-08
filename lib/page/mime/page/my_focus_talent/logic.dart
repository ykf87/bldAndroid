import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';
import 'package:SDZ/event/follow_envent.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/event_bus_util.dart';

import 'state.dart';

class MyFocusTalentLogic extends GetxController {
  final state = My_focus_talentState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.list.clear();
    state.pageNum = 1;
    state.list.clear();
    getData();
    EventBusUtils.getInstance().fire(UserCenterEvent()); //刷新个人中心数据
    state.userCenterEventBus = EventBusUtils.getInstance().on<UserCenterEvent>().listen((event) {
    doRefresh();
    });
  }

  //取消关注
  void cancleFocus(int index) {
    Map<String, dynamic> map = new Map();
    map['accountId'] = state.list[index];
    ApiClient.instance.delete('${ApiUrl.following}/?accountId=${state.list[index].accountId}',
        onSuccess: (data) {
      EventBusUtils.getInstance().fire(FollowEvent(accountId: state.list[index].accountId,isFollow: false));
      state.list.removeAt(index);
      state.isShowEmpty = state.list.length == 0;
      EventBusUtils.getInstance().fire(UserCenterEvent()); //刷新个人中心数据
      update();
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
    ApiClient.instance.get(ApiUrl.followers, data: map, onSuccess: (data) {
      BaseEntity<List<MyFocusTalentEntity>> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        if(state.pageNum == 1){
          state.list.clear();
        }
        List<MyFocusTalentEntity>? list = entity.data;
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
      state.refreshController.finishRefresh(success: true);
      if (state.pageNum > 1) {
        state.pageNum--;
      }
      update();
    });
  }
}
