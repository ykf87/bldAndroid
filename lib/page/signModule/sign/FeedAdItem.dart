import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/YLHUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

class FeedAdItem extends StatefulWidget {
  double adWidth = 0;
  int adType = 1;

  FeedAdItem(this.adWidth, {this.adType = 1});

  @override
  _FeedAdItemState createState() => _FeedAdItemState();
}

class _FeedAdItemState extends State<FeedAdItem> {
  List<int> feedAdList = [];

  @override
  void initState() {
    // TODO: implement initState
    widget.adType == 1 ? getCSJFeedAdList() : getYLHFeedAdList();
    super.initState();
  }

  @override
  void dispose() {
    clearYLHFeedAd();
    clearCSJFeedAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return feedAdList.length != 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: widget.adType == 1
                ? CSJ.AdFeedWidget(
                    posId: '${feedAdList[0]}',
                    width: double.infinity,
                    height: 100,
                    show: true,
                  )
                : AdFeedWidget(
                    posId: '${feedAdList[0]}',
                    width: double.infinity,
                    height: 128,
                    show: true,
                  ),
          )
        : Container();
  }

  // 加载信息流广告
  Future<void> getCSJFeedAdList() async {
    try {
      print('TTTTCSJ==${widget.adWidth}');
      List<int> adResultList = await CSJ.FlutterPangleAds.loadFeedAd(
        CSJUtils.CSJWaterFall,
        width: (widget.adWidth / 2).toInt(),
        count: 1,
      );
      feedAdList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  // 清除信息流广告
  Future<void> clearCSJFeedAd() async {
    bool result = await CSJ.FlutterPangleAds.clearFeedAd(feedAdList);
    print('clearFeedAd:$result');
  }

  // 加载信息流广告
  Future<void> getYLHFeedAdList() async {
    try {
      print('TTTT==${widget.adWidth}');
      List<int> adResultList = await FlutterQqAds.loadFeedAd(
        YLHUtils.YLHWaterFallId,
        width: (widget.adWidth / 2).toInt(),
        count: 1,
      );
      feedAdList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  // 清除信息流广告
  Future<void> clearYLHFeedAd() async {
    bool result = await FlutterQqAds.clearFeedAd(feedAdList);
    print('clearFeedAd:$result');
  }
}
