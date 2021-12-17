import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'dart:ffi';

goodsEntityFromJson(GoodsEntity data, Map<String, dynamic> json) {
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsThumbUrl'] != null) {
		data.goodsThumbUrl = json['goodsThumbUrl'].toString();
	}
	if (json['marketPrice'] != null) {
		data.marketPrice = json['marketPrice'] is String
				? double.tryParse(json['marketPrice'])
				: json['marketPrice'].toDouble();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? double.tryParse(json['price'])
				: json['price'].toDouble();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'].toString();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'].toString();
	}
	if (json['commissionRate'] != null) {
		data.commissionRate = json['commissionRate'].toString();
	}
	if (json['commission'] != null) {
		data.commission = json['commission'] is String
				? double.tryParse(json['commission'])
				: json['commission'].toDouble();
	}
	return data;
}

Map<String, dynamic> goodsEntityToJson(GoodsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
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