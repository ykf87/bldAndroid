// Flutter imports:
// Package imports:
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/core/utils/utils.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/home/telephone_bill_entity.dart';
import 'package:SDZ/page/menu/about.dart';
import 'package:SDZ/page/waimai/index.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:

import 'menu_item.dart';
import 'model.dart';

const elmImage = 'assets/svg/elm_logo.svg';
const phbImage = 'assets/svg/phb.svg';
const zheImage = 'assets/svg/zhe.svg';
const banjiaImage = 'assets/svg/banjia.svg';
const mtwmImage = 'assets/svg/mt.svg';
const chf = 'assets/svg/chf.svg'; // 充话费
const pp = 'assets/svg/pp.svg'; // 品牌
const jd = 'assets/svg/jd.svg'; // 京东
const pyq = 'assets/svg/pyq.svg'; // 朋友圈
const didid = 'assets/svg/didi.svg'; // 朋友圈

final gridMenuModles = [
  /// 领券
  GridMenuItem(
      item: GridMenuModel(
          title: '饿了吗',
          image: elmImage,
          isAssets: true,
          onTap: () {
            Get.context!.navigator
                .push(SwipeablePageRoute(builder: (_) => WaimaiIndex()));
          })),

  GridMenuItem(
      item: GridMenuModel(
          title: '美团领券',
          image: mtwmImage,
          onTap: () async {
            CSJUtils.showRewardVideoAd();
          },
          isAssets: true,
          onLongTap: () async {
            Get.context!.navigator
                .push(SwipeablePageRoute(builder: (_) => AboutPage()));
          })),

  GridMenuItem(
      item: GridMenuModel(
          title: '8折话费',
          image: chf,
          onTap: () {
            getMobileData();
          },
          isAssets: true)),

  /// 电费充值
  GridMenuItem(
      item: GridMenuModel(
          title: '电费充值',
          image: phbImage,
          onTap: () {
            getElectricityData();
          },
          isAssets: true)),

  /// 滴滴出行
  GridMenuItem(
      item: GridMenuModel(
          title: '滴滴出行',
          image: didid,
          onTap: () {
            getDiDiData();
          },
          isAssets: true)),

  // GridMenuItem(
  //     item: GridMenuModel(
  //         title: '每日半价',
  //         image: banjiaImage,
  //         onTap: () {
  //           Get.context!.navigator
  //               .push(SwipeablePageRoute(builder: (_) => AboutPage()));
  //         },
  //         isAssets: true)),
  //
  // GridMenuItem(
  //     item: GridMenuModel(
  //         title: '拼夕夕',
  //         image: 'assets/svg/pdd.svg',
  //         onTap: () {
  //           Get.context!.navigator
  //               .push(SwipeablePageRoute(builder: (_) => AboutPage()));
  //         },
  //         isAssets: true)),
  //
  //
  // GridMenuItem(
  //     item: GridMenuModel(
  //         title: '精选品牌',
  //         image: pp,
  //         onTap: () {
  //           Get.context!.navigator
  //               .push(SwipeablePageRoute(builder: (_) => AboutPage()));
  //         },
  //         isAssets: true)),
  //
  // GridMenuItem(
  //     item: GridMenuModel(
  //         title: '京东好货',
  //         image: jd,
  //         onTap: () {
  //           Get.context!.navigator
  //               .push(SwipeablePageRoute(builder: (_) => AboutPage()));
  //         },
  //         isAssets: true)),
];

///话费
void getMobileData() {

  Map<String, dynamic> map = Map();
  map['apikey'] = JtkApi.apikey;
  map['sid'] = "bld";
  map['pub_id'] = JtkApi.pub_id;

  ApiClient.instance.get(ApiUrl.mobile, data: map, isJTK: true,
      onSuccess: (data) {
        BaseEntity<TelephoneBillEntity> entity = BaseEntity.fromJson(data!);
        if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
          launch(entity.data?.jtk_url??'');
        }else{
        }

      });
}

///电费
void getElectricityData() {

  Map<String, dynamic> map = Map();
  map['apikey'] = JtkApi.apikey;
  map['sid'] = "bld";
  map['pub_id'] = JtkApi.pub_id;

  ApiClient.instance.get(ApiUrl.electricity, data: map, isJTK: true,
      onSuccess: (data) {
        BaseEntity<TelephoneBillEntity> entity = BaseEntity.fromJson(data!);
        if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
          launch(entity.data?.h5_url??'');
        }else{
        }

      });
}

///滴滴
void getDiDiData() {

  Map<String, dynamic> map = Map();
  map['apikey'] = JtkApi.apikey;
  map['sid'] = "bld";
  map['pub_id'] = JtkApi.pub_id;
  map['type'] = 1;

  ApiClient.instance.get(ApiUrl.didi, data: map, isJTK: true,
      onSuccess: (data) {
        BaseEntity<TelephoneBillEntity> entity = BaseEntity.fromJson(data!);
        if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
          launch(entity.data?.short_click_url??'');
        }else{
        }

      });
}

/// 首页的网格菜单
class GridMenuComponent extends StatelessWidget {
  const GridMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: WaterfallFlow.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: gridMenuModles,
        ),
      ),
    );
  }
}
