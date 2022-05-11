// Flutter imports:
// Package imports:
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/entity/sign/gift_entity.dart';
import 'package:SDZ/page/home/goods_detail/detail.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/navigator_util.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/coupon_price.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/extended_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';

// 赠品列表
class GiftItem extends StatelessWidget {
  final GiftEntity product;
  final String? source;
  final Function onSelGift;

  const GiftItem(this.product, this.onSelGift, {this.source = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            //width: Sc.ScreenUtil().setWidth(640), // (1440-150) / 2
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    _image(),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          onSelGift.call();
                        },
                        onDoubleTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 8, right: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffFC6E18),
                              Color(0xffFF421A),
                            ]),
                            borderRadius:
                                BorderRadius.circular(Adaptor.width(20)),
                          ),
                          child: Center(
                            child: Text(
                              '选为签到奖品',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Adaptor.sp(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 5),

                // 标题
                _title(product.title ?? ''),

                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Container(
                        child: const Text('连续签到',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 12)),
                      ),
                      Text(
                        '${product.days ?? 7}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colours.color_orange_ffFF7648,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '天即可获得',
                        style: const TextStyle(
                            color: Colors.black38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.only(right: 3.0),
                      //   child: const Text('市场价', style: TextStyle(
                      //       color: Colors.black38, fontSize: 12)),
                      // ),
                      Text(
                        '¥${product.sale.toString()}',
                        style: const TextStyle(
                            color: Colours.color_orange_ffFF7648,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('已送出${product.sendout}份',
                          style: TextStyle(color: Colors.black38, fontSize: 10))
                    ],
                  ),
                ),
              ],
            )));
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
    var img = product.images?[0] ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
      child: ImageFade(
        image: NetworkImage(img),
        placeholder: Container(
          height: 140,
          width: double.infinity,
          color: Color(0xFFCFCDCA),
        ),
      ),
      // child: CachedNetworkImage(
      //     fit: BoxFit.fill,
      //     width: double.infinity,
      //     imageUrl: img)
    );
  }
}
