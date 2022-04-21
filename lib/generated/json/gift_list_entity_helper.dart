import 'package:SDZ/entity/sign/gift_entity.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';

giftListEntityFromJson(GiftListEntity data, Map<String, dynamic> json) {
	if (json['list'] != null) {
		data.xList = (json['list'] as List).map((v) => GiftEntity().fromJson(v)).cast<GiftEntity>().toList();
	}
	return data;
}

Map<String, dynamic> giftListEntityToJson(GiftListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['list'] =  entity.xList?.map((v) => v.toJson())?.toList();
	return data;
}