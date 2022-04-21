import 'package:SDZ/entity/waimai/goods_detail_entity.dart';

goodsDetailEntityFromJson(GoodsDetailEntity data, Map<String, dynamic> json) {
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsThumbUrl'] != null) {
		data.goodsThumbUrl = json['goodsThumbUrl'].toString();
	}
	if (json['marketPrice'] != null) {
		data.marketPrice = json['marketPrice'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'].toString();
	}
	if (json['sales_tip'] != null) {
		data.salesTip = json['sales_tip'] is String
				? int.tryParse(json['sales_tip'])
				: json['sales_tip'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'].toString();
	}
	if (json['commissionRate'] != null) {
		data.commissionRate = json['commissionRate'].toString();
	}
	if (json['commission'] != null) {
		data.commission = json['commission'].toString();
	}
	if (json['shopName'] != null) {
		data.shopName = json['shopName'].toString();
	}
	return data;
}

Map<String, dynamic> goodsDetailEntityToJson(GoodsDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
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