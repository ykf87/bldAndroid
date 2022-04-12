import 'dart:async';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/event/ad_reward_event.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/refresh_signPage_event.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:flutter_pangle_ads/event/ad_reward_event.dart';
import 'package:get/get.dart';

import 'state.dart';

class AdTaskLogic extends GetxController {
  final state = AdTaskState();

  StreamSubscription<RefreshSignPageEvent>? refreshEventBus;
  StreamSubscription<LoginEvent>? loginEventBus;
  StreamSubscription<MyAdRewardEvent>? adRewardEventBus;
  bool isDoReward = false;

  void initEvent() {
    loginEventBus =
        EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      getData();
    });
    adRewardEventBus =
        EventBusUtils.getInstance().on<MyAdRewardEvent>().listen((event) {
      if (state.curEntity != null) {
        if (isDoReward) {
          videoSuccess(state.curEntity!.id.toString());
          isDoReward = false;
          print('任务中心视频成功');
        }
      }
    });
  }

  void getData() {
    Map<String, dynamic> map = new Map();
    map['pageNum'] = state.pageNum;
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.task, data: map,
        onSuccess: (data) {
      BaseEntity<List<AdTaskEntity>> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        List<AdTaskEntity>? list = entity.data;
        state.refreshController.finishLoad(noMore: list!.length < 30);
        state.refreshController.finishRefresh(success: true);
        for (int i = 0; i < list.length; i++) {
          list[i].resType = (i + 1) % 5;
        }
        if (state.pageNum == 1) {
          state.list = entity.data ?? [];
        } else {
          state.list.addAll(list);
        }
        state.isShowEmpty = state.list.length == 0;
      } else {
        state.isShowEmpty = state.list.length == 0;
      }
      if (!SPUtils.getAdShow()) {
        state.isShowEmpty = true;
      }
      update();
    }, onError: (msg) {
      state.isShowEmpty = state.list.length == 0;
      if (!SPUtils.getAdShow()) {
        state.isShowEmpty = true;
      }
      state.refreshController.finishLoad(noMore: true);
      state.refreshController.finishRefresh(success: true);
      if (state.pageNum > 1) {
        state.pageNum--;
      }
      update();
    });
  }

  void videoSuccess(String id) {
    Map<String, dynamic> map = new Map();
    map['tid'] = id;
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.videoSuccess,
        data: map, onSuccess: (data) {
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        doRefresh();
        ToastUtils.toast('奖励已到账');
      }
      update();
    }, onError: (msg) {});
  }

  void getUserInfo() {
    if (!LoginUtil.isLogin()) {
      return;
    }
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.center,
        onSuccess: (data) {
      BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        state.userCenterEntity = entity.data;
        update();
      }
    });
  }

  void doRefresh() {
    state.pageNum = 1;
    getData();
    getUserInfo();
  }

  void doLoadMore() {
    state.pageNum++;
    getData();
  }
}
