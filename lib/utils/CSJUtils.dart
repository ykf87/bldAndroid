import 'package:SDZ/event/ad_reward_event.dart';
import 'package:SDZ/res/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;

import 'event_bus_util.dart';

class CSJUtils {
  static const String CSJAPPID = '5264512'; //穿山甲appid
  static const String CSJSplashId = '887675916'; //穿山甲开屏id
  static const String CSJVideoId = '947697728'; //穿山甲激励视频id
  static const String CSJInteractionId = '947697731'; //穿山甲插屏id
  static const String CSJBannerId = '947697730'; //穿山甲bannerid

  static const String YLHAPPID = '1200402924'; //优量汇id
  static const String YLHVideoId = '1042190702729526'; //优量汇激励视频id
  /// 初始化广告 SDK
  static Future<bool> initCSJADSDK() async {
    String _result = '';
    try {
      bool result = await FlutterPangleAds.initAd(
        CSJUtils.CSJAPPID,
        directDownloadNetworkType: [
          NetworkType.kNetworkStateMobile,
          NetworkType.kNetworkStateWifi,
        ],
      );
      _result = "广告SDK 初始化${result ? '成功' : '失败'}";
      return result;
    } on PlatformException catch (e) {
      _result =
          "广告SDK 初始化失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    return false;
  }

  /// 展示插屏广告
  static Future<void> showInterstitialAd() async {
    String _result = '';
    try {
      bool result = await FlutterPangleAds.showInterstitialAd(
        CSJUtils.CSJInteractionId,
        width: 300,
        height: 300,
      );
      _result = "展示插屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示插屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
  }

  /// 展示激励视频广告
  static Future<void> showRewardVideoAd() async {
    String _result = '';
    try {
      bool result = await FlutterPangleAds.showRewardVideoAd(
        CSJUtils.CSJVideoId,
        customData: 'customData',
        userId: '123456',
      );
      _result = "展示激励视频广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result =
          "展示激励视频广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
  }

  /// 设置穿山甲广告监听
  static Future<void> setCSJAdEvent() async {
    String _adEvent = '';
    bool onAdReward = false;
    CSJ.FlutterPangleAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is CSJ.AdErrorEvent) {
        // 错误事件
      }

      ///获取奖励
      if (event.action == CSJ.AdEventAction.onAdReward &&
          event.adId == CSJUtils.CSJVideoId) {
        onAdReward = true;
      }
      if (event.action == CSJ.AdEventAction.onAdClosed && onAdReward) {
        onAdReward = false;
        EventBusUtils.getInstance()
            .fire(MyAdRewardEvent(MyAdRewardEvent.TYPE_CSJ));
      }
    });
  }
}
