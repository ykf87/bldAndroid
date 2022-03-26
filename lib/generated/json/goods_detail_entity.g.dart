import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/waimai/goods_detail_entity.dart';

GoodsDetailEntity $GoodsDetailEntityFromJson(Map<String, dynamic> json) {
	final GoodsDetailEntity goodsDetailEntity = GoodsDetailEntity();
	final String? goodsName = jsonConvert.convert<String>(json['goodsName']);
	if (goodsName != null) {
		goodsDetailEntity.goodsName = goodsName;
	}
	final String? goodsThumbUrl = jsonConvert.convert<String>(json['goodsThumbUrl']);
	if (goodsThumbUrl != null) {
		goodsDetailEntity.goodsThumbUrl = goodsThumbUrl;
	}
	final String? marketPrice = jsonConvert.convert<String>(json['marketPrice']);
	if (marketPrice != null) {
		goodsDetailEntity.marketPrice = marketPrice;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		goodsDetailEntity.price = price;
	}
	final String? discount = jsonConvert.convert<String>(json['discount']);
	if (discount != null) {
		goodsDetailEntity.discount = discount;
	}
	final int? salesTip = jsonConvert.convert<int>(json['sales_tip']);
	if (salesTip != null) {
		goodsDetailEntity.salesTip = salesTip;
	}
	final String? goodsId = jsonConvert.convert<String>(json['goodsId']);
	if (goodsId != null) {
		goodsDetailEntity.goodsId = goodsId;
	}
	final String? commissionRate = jsonConvert.convert<String>(json['commissionRate']);
	if (commissionRate != null) {
		goodsDetailEntity.commissionRate = commissionRate;
	}
	final String? commission = jsonConvert.convert<String>(json['commission']);
	if (commission != null) {
		goodsDetailEntity.commission = commission;
	}
	final String? shopName = jsonConvert.convert<String>(json['shopName']);
	if (shopName != null) {
		goodsDetailEntity.shopName = shopName;
	}
	return goodsDetailEntity;
}

Map<String, dynamic> $GoodsDetailEntityToJson(GoodsDetailEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['goodsName'] = entity.goodsName;
	data['goodsThumbUrl'] = entity.goodsThumbUrl;
	data['marketPrice'] = entity.marketPrice;
	data['price'] = entity.price;
	data['discount'] = entity.discount;
	data['sales_tip'] = entity.salesTip;
	data['goodsId'] = entity.goodsId;
	data['commissionRate'] = entity.commissionRate;
	data['commission'] = entity.commission;
	data['shopName'] = entity.shopName;
	return data;
}