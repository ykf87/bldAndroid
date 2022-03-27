import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';
import 'package:SDZ/entity/sign_info_entity.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignLogic extends GetxController {
  final state = SignState();


  ///签到信息
  void getSignInfo() {
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.signedInfo, isJTK: false, onSuccess: (data) {
          BaseEntity<SignInfoEntity> entity = BaseEntity.fromJson(data!);
          state.signInfoEntity = entity.data??new SignInfoEntity();
          if(state.signInfoEntity != null && state.signInfoEntity?.signed != null
              && state.signInfoEntity!.signed!.need_day > 6
              && state.signInfoEntity!.signed!.days! > 6){
            state.listScroll.jumpTo(38.0*state.signInfoEntity!.signed!.days!);
          }
          setSignBtnStatus();
          update();
        }, onError: (msg) {
          EasyLoading.dismiss();
        });
  }


  ///签到按钮状态 0：未选商品 1：已签到 （0,1置灰）  2：签到 3:补签 4：签到完成，领取奖品
   int setSignBtnStatus(){
    ///未选择签到奖品
    if(state.signInfoEntity!.signed == null){
      state.tipsText = '请先选择签到奖品再进行签到~';
      state.btnText = '签到';
      state.isBtnEnable = false;
      return 0;
    }else{
      if(state.signInfoEntity!.signed!.days == state.signInfoEntity!.signed!.need_day){
        ///签到完成，领奖品
        state.tipsText = '签到任务已完成，恭喜您获得奖品';
        state.btnText = '领取奖品';
        state.isBtnEnable = true;
        return 4;
      }
      if(state.signInfoEntity!.signed!.mustadv){
        ///补签
        state.tipsText = '昨日还未签到，观看广告可进行补签';
        state.btnText = '去补签';
        state.isBtnEnable = true;
        return 3;
      }
      if(state.signInfoEntity!.issigin){
        state.tipsText = '';
        state.btnText = '今日已签到';
        state.isBtnEnable = false;
        return 1;
      }else{
        state.tipsText = '';
        state.btnText = '签到';
        state.isBtnEnable = true;
        return 2;
      }
    }
  }

  void signClick(){
    if(setSignBtnStatus() == 0 || setSignBtnStatus() == 1){
      return;
    }else if(setSignBtnStatus() == 2){
      //签到
      sign();
    }else if(setSignBtnStatus() == 3){
      //补签
      csjVedio();
    }else if(setSignBtnStatus() == 4){
      //领奖品
    }
  }
  ///签到
  void sign() {
    Map<String, dynamic> map = Map();
    map['id'] =  state.signInfoEntity?.signed?.id;
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.doSign,data: map, isJTK: false, onSuccess: (data) {
      BaseEntity<SignInfoEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        ToastUtils.toast("签到成功");
      }else{
        ToastUtils.toast("签到失败，请重试");
      }
      state.signInfoEntity = entity.data;
      setSignBtnStatus();
      getSignInfo();
      update();
    }, onError: (msg) {
      EasyLoading.dismiss();
    });
  }


  ///签到奖品列表
  void getGiftList() {
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['limit'] = 30;
    EasyLoading.showToast('加载中...');
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.giftList,
        data: map, isJTK: false, onSuccess: (data) {
      EasyLoading.dismiss();
      BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);
      state.list.clear();
      state.list.addAll(entity.data?.list ?? []);
      update();
    }, onError: (msg) {
      EasyLoading.dismiss();
    });
  }

  ///选中签到奖品
  void commitGift(GiftEntity entity, BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (_) => ExitDialog(
            onPressed: () {
              Map<String, dynamic> map = Map();
              map['product_id'] = entity.id;
              EasyLoading.showToast('加载中...');
              ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.chooseGift,
                  data: map, isJTK: false, onSuccess: (data) {
                EasyLoading.dismiss();
                BaseEntity<GiftListEntity> entity = BaseEntity.fromJson(data!);
                getSignInfo();
                update();
              }, onError: (msg) {
                EasyLoading.dismiss();
              });
            },
            content:state.signInfoEntity?.signed != null?
            '当前已有签到奖品"${state.signInfoEntity?.signed?.product?.name}",若选择新的奖品，将从第一天开始重新签到':
            '确认要选择${entity.name}为签到奖品吗？'));
  }

  ///优量汇
  void ylhVedio(){
    FlutterQqAds.showRewardVideoAd(
      CSJUtils.YLHVideoId,
      playMuted: false,
      customData: 'customData',
      userId: 'userId',
    );
  }

  ///穿山甲
  void csjVedio(){
    CSJUtils.showRewardVideoAd();
  }

  /// 设置穿山甲广告监听
  Future<void> setCSJAdEvent() async {
    String _adEvent = '';
    CSJ.FlutterPangleAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is CSJ.AdErrorEvent) {
        // 错误事件
      }
      ///获取奖励
      if (event.action == CSJ.AdEventAction.onAdReward &&
          event.adId == CSJUtils.CSJVideoId) {
        sign();
      }
    });
  }

  /// 设置优量汇广告监听
  Future<void> setYLHAdEvent() async {
    FlutterQqAds.onEventListener((event) {
      // 普通广告事件
      String _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is AdErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      } else if (event is AdRewardEvent && event.adId == CSJUtils.YLHVideoId) {
        // 激励事件
        sign();
      }
      print('onEventListener:$_adEvent');
    });
  }
}
