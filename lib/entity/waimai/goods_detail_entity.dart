import 'package:SDZ/generated/json/goods_detail_entity.g.dart';

import 'package:SDZ/generated/json/base/json_field.dart';

@JsonSerializable()
class GoodsDetailEntity {

	GoodsDetailEntity();

	factory GoodsDetailEntity.fromJson(Map<String, dynamic> json) => $GoodsDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GoodsDetailEntityToJson(this);

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
