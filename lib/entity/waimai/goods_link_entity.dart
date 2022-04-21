import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class GoodsLinkEntity with JsonConvert<GoodsLinkEntity> {
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

class GoodsLinkCouponInfo with JsonConvert<GoodsLinkCouponInfo> {
	int? fav;
	String? useEndTime;
	String? useBeginTime;
}

class GoodsLinkWeAppInfo with JsonConvert<GoodsLinkWeAppInfo> {
	@JSONField(name: "app_id")
	String? appId;
	@JSONField(name: "page_path")
	String? pagePath;
}
