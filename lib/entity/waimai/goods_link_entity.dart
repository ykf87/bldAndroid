import 'package:SDZ/generated/json/goods_link_entity.g.dart';

import 'package:SDZ/generated/json/base/json_field.dart';

@JsonSerializable()
class GoodsLinkEntity {

	GoodsLinkEntity();

	factory GoodsLinkEntity.fromJson(Map<String, dynamic> json) => $GoodsLinkEntityFromJson(json);

	Map<String, dynamic> toJson() => $GoodsLinkEntityToJson(this);

	String? goodsId;
	String? goodsName;
	String? price;//折扣/券后价
	String? marketPrice;
	@JSONField(name: "sales_tip")
	int? salesTip;
	String? discount;
	String? commissionRate;
	String? commission;
	GoodsLinkCouponInfo? couponInfo;
	@JSONField(name: "we_app_info")
	GoodsLinkWeAppInfo? weAppInfo;
	String? url;//推广链接
	List<String>? goodsCarouselPictures;
	List<String>? goodsDetailPictures;
	String? shopName;
	String? expression;

	int shopType = 1;///1:淘宝 2：pdd 3:jd
}

@JsonSerializable()
class GoodsLinkCouponInfo {

	GoodsLinkCouponInfo();

	factory GoodsLinkCouponInfo.fromJson(Map<String, dynamic> json) => $GoodsLinkCouponInfoFromJson(json);

	Map<String, dynamic> toJson() => $GoodsLinkCouponInfoToJson(this);

	int? fav;
	String? useEndTime;
	String? useBeginTime;
}

@JsonSerializable()
class GoodsLinkWeAppInfo {

	GoodsLinkWeAppInfo();

	factory GoodsLinkWeAppInfo.fromJson(Map<String, dynamic> json) => $GoodsLinkWeAppInfoFromJson(json);

	Map<String, dynamic> toJson() => $GoodsLinkWeAppInfoToJson(this);

	@JSONField(name: "app_id")
	String? appId;
	@JSONField(name: "page_path")
	String? pagePath;
}
