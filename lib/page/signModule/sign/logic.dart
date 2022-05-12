import 'dart:async';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/sign/gift_entity.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';
import 'package:SDZ/entity/sign/sign_info_entity.dart';
import 'package:SDZ/event/ad_reward_event.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/refresh_signPage_event.dart';
import 'package:SDZ/page/signModule/address/view.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/VideoUtils.dart';
import 'package:SDZ/utils/YLHUtils.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignLogic extends GetxController {
  final state = SignState();
  StreamSubscription<RefreshSignPageEvent>? refreshEventBus;
  StreamSubscription<LoginEvent>? loginEventBus;
  StreamSubscription<MyAdRewardEvent>? adRewardEventBus;
  bool isDoReward = false;

  void initEvent() {
    loginEventBus =
        EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      getSignInfo();
      getGiftList();
      update();
    });
    refreshEventBus =
        EventBusUtils.getInstance().on<RefreshSignPageEvent>().listen((event) {
      getSignInfo();
      getGiftList();
    });
    adRewardEventBus =
        EventBusUtils.getInstance().on<MyAdRewardEvent>().listen((event) {
      print("onEventListener:接收到成功");
      if (isDoReward) {
        sign();
        isDoReward = false;
      }
    });
  }

  ///签到信息
  void getSignInfo() {
    if(!LoginUtil.isLogin()){
      return;
    }
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.signedInfo,
        isJTK: false, onSuccess: (data) {
      BaseEntity<SignInfoEntity> entity = BaseEntity.fromJson(data!);
      state.signInfoEntity = entity.data ?? new SignInfoEntity();
      if (state.signInfoEntity != null &&
          state.signInfoEntity?.signed != null &&
          state.signInfoEntity!.signed!.needDay > 6 &&
          state.signInfoEntity!.signed!.days! > 6) {
        state.listScroll.jumpTo(38.0 * state.signInfoEntity!.signed!.days!);
      }
      setSignBtnStatus();
      update();
    }, onError: (msg) {
      EasyLoading.dismiss();
    });
  }

  ///签到按钮状态 0：未选商品 1：已签到 （0,1置灰）  2：签到 3:补签 4：签到完成，领取奖品
  int setSignBtnStatus() {
    ///未选择签到奖品
    if (state.signInfoEntity!.signed == null) {
      state.tipsText = '请先选择签到奖品再进行签到~';
      state.btnText = '签到';
      state.isBtnEnable = false;
      return 0;
    } else {
      if (state.signInfoEntity!.signed!.days ==
          state.signInfoEntity!.signed!.needDay) {
        ///签到完成，领奖品
        state.tipsText = '签到任务已完成，恭喜您获得奖品';
        state.btnText = '领取奖品';
        state.isBtnEnable = true;
        return 4;
      }
      if (state.signInfoEntity!.signed!.mustadv??false) {
        ///补签
        state.tipsText = '昨日还未签到，观看广告可进行补签';
        state.btnText = '去补签';
        state.isBtnEnable = true;
        return 3;
      }
      if (state.signInfoEntity!.issigin??false) {
        state.tipsText = '';
        state.btnText = '今日已签到';
        state.isBtnEnable = false;
        return 1;
      } else {
        state.tipsText = '';
        state.btnText = '签到';
        state.isBtnEnable = true;
        return 2;
      }
    }
  }

  void signClick() {
    if (setSignBtnStatus() == 0 || setSignBtnStatus() == 1) {
      return;
    } else if (setSignBtnStatus() == 2) {
      //签到
      sign();
    } else if (setSignBtnStatus() == 3) {
      //补签
      isDoReward = true;
      csjVedio();
      // ylhVedio();
    } else if (setSignBtnStatus() == 4) {
      //领奖品
      print("id===${state.signInfoEntity?.signed?.id}");
      Get.to(AddressPage(taskId: state.signInfoEntity?.signed?.id ?? 0));
    }
  }

  ///签到
  void sign() {
    if (!LoginUtil.isLogin()) {
      LoginUtil.toLogin();
      return;
    }
    Map<String, dynamic> map = Map();
    map['id'] = state.signInfoEntity?.signed?.id;
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.doSign,
        data: map, isJTK: false, onSuccess: (data) {
      BaseEntity<SignInfoEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        ToastUtils.toast("签到成功");
      } else {
        ToastUtils.toast("签到失败，请重试");
      }
      state.signInfoEntity = entity.data;
      setSignBtnStatus();
      getSignInfo();
      update();
    }, onError: (msg) {
      ToastUtils.toast(msg);
      EasyLoading.dismiss();
    });
  }

  doRefresh() {
    page = 1;
    state.list.clear();
    getGiftList();
  }

  doLoadMore() {
    page++;
    getGiftList();
  }

  ///签到奖品列表
  int page = 1;

  void getGiftList() {
    Map<String, dynamic> map = Map();
    map['page'] = page;
    map['limit'] = 30;
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.giftList,
        data: map, isJTK: false, onSuccess: (data) {
      EasyLoading.dismiss();
      BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null && entity.data!.xList != null) {
        state.refreshController
            .finishLoad(noMore: entity.data!.xList!.length < 30);
        state.refreshController.finishRefresh(success: true);
        for (int i = 0; i < 5; i++) {
          GiftEntity giftEntity = new GiftEntity();
          giftEntity.isAd = true;
          if (entity.data!.xList!.length > (i + 1) * 4) {
            entity.data!.xList!.insert((i + 1) * 4, giftEntity);
          }
        }
        state.list.addAll(entity.data?.xList ?? []);
      }
      update();
    }, onError: (msg) {
      state.refreshController.finishLoad(noMore: true,success: true);
      state.refreshController.finishRefresh(success: true);
      if (page > 1) {
        page--;
      }
      update();
      EasyLoading.dismiss();
    });
  }

  ///选中签到奖品
  void commitGift(GiftEntity entity, BuildContext context) {
    if (!LoginUtil.isLogin()) {
      LoginUtil.toLogin();
      return;
    }
    showDialog<void>(
        context: context,
        builder: (_) => ExitDialog(
            onPressed: () {
              Map<String, dynamic> map = Map();
              map['product_id'] = entity.id;
              EasyLoading.showToast('加载中...');
              ApiClient.instance.post(
                  ApiUrl.getBLDBaseUrl() + ApiUrl.chooseGift,
                  data: map,
                  isJTK: false, onSuccess: (data) {
                EasyLoading.dismiss();
                BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);
                getSignInfo();
                update();
              }, onError: (msg) {
                EasyLoading.dismiss();
                ToastUtils.toast(msg);
              });
            },
            content: state.signInfoEntity?.signed != null
                ? '当前已有签到奖品"${state.signInfoEntity?.signed?.product?.name}",若选择新的奖品，将从第一天开始重新签到'
                : '确认要选择“${entity.title}”为签到奖品吗？'));
  }

  void showRule(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        context: context,
        builder: (context) => Container(
              height: 400,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: Text(
                          '签到规则',
                          style: TextStyle(
                              fontSize: 16, color: Colours.color_333333),
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(Utils.getSvgUrl('ic_close.svg'),
                            width: 14, height: 14, color: Colours.color_999999),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: new ListView(
                    children: [
                      Text("1、用户需先选择一个签到奖品，作为签到任务完成后的奖励，"
                          "不同奖品对应不同的签到天数，完成签到任务后即可获得该奖品。"
                          "\n2、若在签到过程中出现漏签一天的，可观看广告进行补签，若连续漏签两天，则重置签到天数，从第一天开始签到。"
                          "\n3、完成签到任务后，需填写您的收货地址，并领取奖品，在个人中心--我的订单处即可查看当前奖品的物流状态。"
                          "\n4、若用户存在违规行为，（包括但不限于虚拟交易，通过技术手段或其他作弊手段获取奖品），省得赚有权取消用户的获奖资格，同时平台"
                          "将依照相关规则或法律进行处理。"
                          "\n5、如出现不可抗力或情势变更的情况，（包括灾害时间，活动受政府机关指令调整，受网络攻击或因系统故障停止的），则平台有权终止/结束活动。"
                          "\n6、省得赚有权根据实际活动对活动规则进行变动和调整，相关变动和调整将另行公布。"),
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ));
  }

  ///优量汇
  void ylhVedio() {
    FlutterQqAds.showRewardVideoAd(
      YLHUtils.YLHVideoId,
      playMuted: false,
      customData: 'customData',
      userId: 'userId',
    );
  }

  ///穿山甲
  void csjVedio() {
    CSJUtils.showRewardVideoAd();
  }
}
