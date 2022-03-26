import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/waimai/goods_link_entity.dart';

GoodsLinkEntity $GoodsLinkEntityFromJson(Map<String, dynamic> json) {
	final GoodsLinkEntity goodsLinkEntity = GoodsLinkEntity();
	final String? goodsId = jsonConvert.convert<String>(json['goodsId']);
	if (goodsId != null) {
		goodsLinkEntity.goodsId = goodsId;
	}
	final String? goodsName = jsonConvert.convert<String>(json['goodsName']);
	if (goodsName != null) {
		goodsLinkEntity.goodsName = goodsName;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		goodsLinkEntity.price = price;
	}
	final String? marketPrice = jsonConvert.convert<String>(json['marketPrice']);
	if (marketPrice != null) {
		goodsLinkEntity.marketPrice = marketPrice;
	}
	final int? salesTip = jsonConvert.convert<int>(json['sales_tip']);
	if (salesTip != null) {
		goodsLinkEntity.salesTip = salesTip;
	}
	final String? discount = jsonConvert.convert<String>(json['discount']);
	if (discount != null) {
		goodsLinkEntity.discount = discount;
	}
	final String? commissionRate = jsonConvert.convert<String>(json['commissionRate']);
	if (commissionRate != null) {
		goodsLinkEntity.commissionRate = commissionRate;
	}
	final String? commission = jsonConvert.convert<String>(json['commission']);
	if (commission != null) {
		goodsLinkEntity.commission = commission;
	}
	final GoodsLinkCouponInfo? couponInfo = jsonConvert.convert<GoodsLinkCouponInfo>(json['couponInfo']);
	if (couponInfo != null) {
		goodsLinkEntity.couponInfo = couponInfo;
	}
	final GoodsLinkWeAppInfo? weAppInfo = jsonConvert.convert<GoodsLinkWeAppInfo>(json['we_app_info']);
	if (weAppInfo != null) {
		goodsLinkEntity.weAppInfo = weAppInfo;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		goodsLinkEntity.url = url;
	}
	final List<String>? goodsCarouselPictures = jsonConvert.convertListNotNull<String>(json['goodsCarouselPictures']);
	if (goodsCarouselPictures != null) {
		goodsLinkEntity.goodsCarouselPictures = goodsCarouselPictures;
	}
	final List<String>? goodsDetailPictures = jsonConvert.convertListNotNull<String>(json['goodsDetailPictures']);
	if (goodsDetailPictures != null) {
		goodsLinkEntity.goodsDetailPictures = goodsDetailPictures;
	}
	final String? shopName = jsonConvert.convert<String>(json['shopName']);
	if (shopName != null) {
		goodsLinkEntity.shopName = shopName;
	}
	final String? expression = jsonConvert.convert<String>(json['expression']);
	if (expression != null) {
		goodsLinkEntity.expression = expression;
	}
	final int? shopType = jsonConvert.convert<int>(json['shopType']);
	if (shopType != null) {
		goodsLinkEntity.shopType = shopType;
	}
	return goodsLinkEntity;
}

Map<String, dynamic> $GoodsLinkEntityToJson(GoodsLinkEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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
	data['goodsCarouselPictures'] =  entity.goodsCarouselPictures;
	data['goodsDetailPictures'] =  entity.goodsDetailPictures;
	data['shopName'] = entity.shopName;
	data['expression'] = entity.expression;
	data['shopType'] = entity.shopType;
	return data;
}

GoodsLinkCouponInfo $GoodsLinkCouponInfoFromJson(Map<String, dynamic> json) {
	final GoodsLinkCouponInfo goodsLinkCouponInfo = GoodsLinkCouponInfo();
	final int? fav = jsonConvert.convert<int>(json['fav']);
	if (fav != null) {
		goodsLinkCouponInfo.fav = fav;
	}
	final String? useEndTime = jsonConvert.convert<String>(json['useEndTime']);
	if (useEndTime != null) {
		goodsLinkCouponInfo.useEndTime = useEndTime;
	}
	final String? useBeginTime = jsonConvert.convert<String>(json['useBeginTime']);
	if (useBeginTime != null) {
		goodsLinkCouponInfo.useBeginTime = useBeginTime;
	}
	return goodsLinkCouponInfo;
}

Map<String, dynamic> $GoodsLinkCouponInfoToJson(GoodsLinkCouponInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fav'] = entity.fav;
	data['useEndTime'] = entity.useEndTime;
	data['useBeginTime'] = entity.useBeginTime;
	return data;
}

GoodsLinkWeAppInfo $GoodsLinkWeAppInfoFromJson(Map<String, dynamic> json) {
	final GoodsLinkWeAppInfo goodsLinkWeAppInfo = GoodsLinkWeAppInfo();
	final String? appId = jsonConvert.convert<String>(json['app_id']);
	if (appId != null) {
		goodsLinkWeAppInfo.appId = appId;
	}
	final String? pagePath = jsonConvert.convert<String>(json['page_path']);
	if (pagePath != null) {
		goodsLinkWeAppInfo.pagePath = pagePath;
	}
	return goodsLinkWeAppInfo;
}

Map<String, dynamic> $GoodsLinkWeAppInfoToJson(GoodsLinkWeAppInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['app_id'] = entity.appId;
	data['page_path'] = entity.pagePath;
	return data;
}