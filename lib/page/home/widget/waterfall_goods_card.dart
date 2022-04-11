// Flutter imports:
// Package imports:
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/page/home/goods_detail/detail.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/navigator_util.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/coupon_price.dart';
import 'package:SDZ/widget/extended_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';

// Project imports:

// 瀑布流商品卡片
class WaterfallGoodsCard extends StatelessWidget {
  final GoodsEntity product;
  final String? source;

  const WaterfallGoodsCard(this.product,{this.source = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => DetailPage(
              goodsId: product.goodsId??'',
              source: source));
        },
        child: Container(
            //width: Sc.ScreenUtil().setWidth(640), // (1440-150) / 2
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: <Widget>[
                _image(),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [renderCals()],
                  ),
                ),
                const SizedBox(height: 5),

                // 标题
                _title(product.goodsName??''),

                const SizedBox(height: 5),
                // // 购买理由
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 12),
                //   child: Text(
                //     product.desc!,
                //     maxLines: 2,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 12),
                //   ),
                // ),

                // SizedBox(height: 12),

                /// 领券标签
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: FSuper(
                    lightOrientation: FLightOrientation.LeftBottom,
                    text:
                        '领 ${product.discount} 元券',
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    strokeColor: Colours.color_orange_ffFF7648,
                    corner: FCorner.all(50),
                    style: const TextStyle(color:Colours.color_orange_ffFF7648),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CouponPriceWidget(
                      actualPrice: product.price.toString(),
                      originalPrice: product.marketPrice?.toDouble()),
                ),
                // Hot(
                //     text:
                //         '两小时销量${product.twoHoursSales ?? 0},月销${product.monthSales}')
              ],
            )));
  }

  /// 销量
  Widget renderCals() {
    return Container();
  }

  /// 店铺类型
  Widget renderShopType() {
    final text =  '淘宝';
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(3)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // 标题
  Widget _title(String dtitle) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                dtitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  // 商品卡片主图
  Widget _image() {
    var img = product.goodsThumbUrl!;
    return  ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0)),
        child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: double.infinity,
            imageUrl: img));
  }
}
