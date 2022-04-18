import 'package:SDZ/event/ad_reward_event.dart';
import 'package:SDZ/res/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

import 'event_bus_util.dart';


class YLHUtils{
  static const String YLHAPPID = '1200402924';//优量汇id
  static const String YLHVideoId = '1042190702729526';//优量汇激励视频id
  static const String YLHWaterFallId = '1063029854352687';//优量汇信息流id


  /// 信息流广告
  static Future<List<int>> showWaterFall() async {
    /// [posId] 广告位 id
    /// [width] 宽度
    /// [height] 高度
    /// [count] 获取广告数量，建议 1~3 个
    List<int> feedAdList = await FlutterQqAds.loadFeedAd(
      YLHWaterFallId,
      width: 375,
      height: 0,
      count: 3,
    );
    print('TTTT优量汇==${feedAdList}');
    return feedAdList;
  }

  /// 设置优量汇广告监听
  static Future<void> setYLHAdEvent() async {
    bool onAdReward = false;
    FlutterQqAds.onEventListener((event) {
      // 普通广告事件
      String _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is AdErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      }
      ///获取奖励
      if (event.action == AdEventAction.onAdReward &&
          event.adId == YLHVideoId) {
        print('onEventListener:奖励了');
        onAdReward = true;
      }
      if (event.action == AdEventAction.onAdClosed && onAdReward) {
        print('onEventListener:发通知了');
        onAdReward = false;
        EventBusUtils.getInstance().fire(MyAdRewardEvent(MyAdRewardEvent.TYPE_YLH));
      }
      print('onEventListener:$_adEvent');
    });
  }
}