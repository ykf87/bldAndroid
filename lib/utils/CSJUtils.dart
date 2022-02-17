import 'package:SDZ/res/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CSJUtils{
  static const String CSJAPPID = '5264512';//穿山甲appid
  static const String CSJSplashId = '887675916';//穿山甲开屏id
  static const String CSJVideoId = '947697728';//穿山甲激励视频id
  static const String CSJInteractionId = '947697731';//穿山甲插屏id
  static const String CSJBannerId = '947697730';//穿山甲bannerid


  static const String YLHAPPID = '1200402924';//优量汇id
  static const String YLHVideoId = '1042190702729526';//优量汇激励视频id
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
}