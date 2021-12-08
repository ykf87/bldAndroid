// Flutter imports:
// Package imports:
import 'package:SDZ/widget/custom_loading.dart';
import 'package:SDZ/widget/simple_appbar.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

// Project imports:
import 'detail.dart';

///领取外卖活动首页

class WaimaiIndex extends StatelessWidget {
  const WaimaiIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: '外卖红包',
      ),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return EasyRefresh.custom(slivers: [renderWaimaihongbao(), renderWaimaiShangChao()]);
  }

  /// 商超红包
  Widget renderWaimaiShangChao() {
    return SliverToBoxAdapter(
      child: GestureDetector(onTap: () => navTo('2'), child: renderImage('assets/images/waimai2.png')),
    );
  }

  /// 普通外卖红包
  Widget renderWaimaihongbao() {
    return SliverToBoxAdapter(
      child: GestureDetector(onTap: () => navTo('1'), child: renderImage('assets/images/waimai1.png')),
    );
  }

  void navTo(String type) {
    Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => WaimaiDetail(type: type)));
  }

  /// 渲染图片
  Widget renderImage(String image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AspectRatio(
        aspectRatio: 1.75,
        child: ExtendedImage.asset(
          image,
          loadStateChanged: loadingState,
        ),
      ),
    );
  }
}
