import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'dart:ffi';


GoodsEntity $GoodsEntityFromJson(Map<String, dynamic> json) {
	final GoodsEntity goodsEntity = GoodsEntity();
	final String? goodsName = jsonConvert.convert<String>(json['goodsName']);
	if (goodsName != null) {
		goodsEntity.goodsName = goodsName;
	}
	final String? goodsThumbUrl = jsonConvert.convert<String>(json['goodsThumbUrl']);
	if (goodsThumbUrl != null) {
		goodsEntity.goodsThumbUrl = goodsThumbUrl;
	}
	final double? marketPrice = jsonConvert.convert<double>(json['marketPrice']);
	if (marketPrice != null) {
		goodsEntity.marketPrice = marketPrice;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		goodsEntity.price = price;
	}
	final String? discount = jsonConvert.convert<String>(json['discount']);
	if (discount != null) {
		goodsEntity.discount = discount;
	}
	final String? goodsId = jsonConvert.convert<String>(json['goodsId']);
	if (goodsId != null) {
		goodsEntity.goodsId = goodsId;
	}
	final String? commissionRate = jsonConvert.convert<String>(json['commissionRate']);
	if (commissionRate != null) {
		goodsEntity.commissionRate = commissionRate;
	}
	final double? commission = jsonConvert.convert<double>(json['commission']);
	if (commission != null) {
		goodsEntity.commission = commission;
	}
	return goodsEntity;
}

Map<String, dynamic> $GoodsEntityToJson(GoodsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['goodsName'] = entity.goodsName;
	data['goodsThumbUrl'] = entity.goodsThumbUrl;
	data['marketPrice'] = entity.marketPrice;
	data['price'] = entity.price;
	data['discount'] = entity.discount;
	data['goodsId'] = entity.goodsId;
	data['commissionRate'] = entity.commissionRate;
	data['commission'] = entity.commission;
	return data;
}