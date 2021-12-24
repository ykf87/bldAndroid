import 'package:SDZ/entity/waimai/goods_link_entity.dart';

goodsLinkEntityFromJson(GoodsLinkEntity data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['marketPrice'] != null) {
		data.marketPrice = json['marketPrice'].toString();
	}
	if (json['sales_tip'] != null) {
		data.salesTip = json['sales_tip'] is String
				? int.tryParse(json['sales_tip'])
				: json['sales_tip'].toInt();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'].toString();
	}
	if (json['commissionRate'] != null) {
		data.commissionRate = json['commissionRate'].toString();
	}
	if (json['commission'] != null) {
		data.commission = json['commission'].toString();
	}
	if (json['couponInfo'] != null) {
		data.couponInfo = GoodsLinkCouponInfo().fromJson(json['couponInfo']);
	}
	if (json['we_app_info'] != null) {
		data.weAppInfo = GoodsLinkWeAppInfo().fromJson(json['we_app_info']);
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['goodsCarouselPictures'] != null) {
		data.goodsCarouselPictures = (json['goodsCarouselPictures'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['goodsDetailPictures'] != null) {
		data.goodsDetailPictures = (json['goodsDetailPictures'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['shopName'] != null) {
		data.shopName = json['shopName'].toString();
	}
	if (json['expression'] != null) {
		data.expression = json['expression'].toString();
	}
	return data;
}

Map<String, dynamic> goodsLinkEntityToJson(GoodsLinkEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['goodsName'] = entity.goodsName;
	data['price'] = entity.price;
	data['marketPrice'] = entity.marketPrice;
	data['sales_tip'] = entity.salesTip;
	data['discount'] = entity.discount;
	data['commissionRate'] = entity.commissionRate;
	data['commission'] = entity.commission;
	data['couponInfo'] = entity.couponInfo?.toJson();
	data['we_app_info'] = entity.weAppInfo?.toJson();
	data['url'] = entity.url;
	data['goodsCarouselPictures'] = entity.goodsCarouselPictures;
	data['goodsDetailPictures'] = entity.goodsDetailPictures;
	data['shopName'] = entity.shopName;
	data['expression'] = entity.expression;
	return data;
}

goodsLinkCouponInfoFromJson(GoodsLinkCouponInfo data, Map<String, dynamic> json) {
	if (json['fav'] != null) {
		data.fav = json['fav'] is String
				? int.tryParse(json['fav'])
				: json['fav'].toInt();
	}
	if (json['useEndTime'] != null) {
		data.useEndTime = json['useEndTime'] is String
				? int.tryParse(json['useEndTime'])
				: json['useEndTime'].toInt();
	}
	if (json['useBeginTime'] != null) {
		data.useBeginTime = json['useBeginTime'] is String
				? int.tryParse(json['useBeginTime'])
				: json['useBeginTime'].toInt();
	}
	return data;
}

Map<String, dynamic> goodsLinkCouponInfoToJson(GoodsLinkCouponInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['fav'] = entity.fav;
	data['useEndTime'] = entity.useEndTime;
	data['useBeginTime'] = entity.useBeginTime;
	return data;
}

goodsLinkWeAppInfoFromJson(GoodsLinkWeAppInfo data, Map<String, dynamic> json) {
	if (json['app_id'] != null) {
		data.appId = json['app_id'].toString();
	}
	if (json['page_path'] != null) {
		data.pagePath = json['page_path'].toString();
	}
	return data;
}

Map<String, dynamic> goodsLinkWeAppInfoToJson(GoodsLinkWeAppInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['app_id'] = entity.appId;
	data['page_path'] = entity.pagePath;
	return data;
}