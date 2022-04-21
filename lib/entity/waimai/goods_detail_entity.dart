import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class GoodsDetailEntity with JsonConvert<GoodsDetailEntity> {
	String? goodsName;
	String? goodsThumbUrl;
	String? marketPrice;
	String? price;
	String? discount;
	@JSONField(name: "sales_tip")
	int? salesTip;
	String? goodsId;
	String? commissionRate;
	String? commission;
	String? shopName;
}
