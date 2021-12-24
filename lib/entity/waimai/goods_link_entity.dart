import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class GoodsLinkEntity with JsonConvert<GoodsLinkEntity> {
	String? goodsId;
	String? goodsName;
	String? price;
	String? marketPrice;
	@JSONField(name: "sales_tip")
	int? salesTip;
	String? discount;
	String? commissionRate;
	String? commission;
	GoodsLinkCouponInfo? couponInfo;
	@JSONField(name: "we_app_info")
	GoodsLinkWeAppInfo? weAppInfo;
	String? url;
	List<String>? goodsCarouselPictures;
	List<String>? goodsDetailPictures;
	String? shopName;
	String? expression;
}

class GoodsLinkCouponInfo with JsonConvert<GoodsLinkCouponInfo> {
	int? fav;
	int? useEndTime;
	int? useBeginTime;
}

class GoodsLinkWeAppInfo with JsonConvert<GoodsLinkWeAppInfo> {
	@JSONField(name: "app_id")
	String? appId;
	@JSONField(name: "page_path")
	String? pagePath;
}
