import 'dart:ffi';

import 'package:SDZ/generated/json/base/json_convert_content.dart';

class GoodsEntity with JsonConvert<GoodsEntity> {
  // goodsName: "夏季薄款抽绳松紧腰高腰弹力舒适垮裤小脚九分裤显瘦女装牛仔裤女",
  // goodsThumbUrl: https: //a.vpimg3.com/upload/merchandise/pdcvis/104218/2021/0319/151/526379cf-152e-4a9a-9b92-1f95a7f4542d_750x750_50.jpg,
  // marketPrice: "299.00",市场价
  // price: "81.00",折扣/券后价
  // discount: "0.46",折扣/券金额，唯品会为折扣
  // goodsId: "6919230262795497541",
  // commissionRate: 20,佣金比例,%比
  // commission: 16.2佣金，单位元
  String? goodsName;
  String? goodsThumbUrl;
  double? marketPrice;
  double? price;
  String? discount;
  String? goodsId;
  String? commissionRate;
  double? commission;
  bool isAd = false;

}
