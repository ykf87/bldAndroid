import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';

GiftListEntity $GiftListEntityFromJson(Map<String, dynamic> json) {
	final GiftListEntity giftListEntity = GiftListEntity();
	final List<GiftEntity>? list = jsonConvert.convertListNotNull<GiftEntity>(json['list']);
	if (list != null) {
		giftListEntity.list = list;
	}
	return giftListEntity;
}

Map<String, dynamic> $GiftListEntityToJson(GiftListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.list?.map((v) => v.toJson()).toList();
	return data;
}

GiftEntity $GiftListListFromJson(Map<String, dynamic> json) {
	final GiftEntity giftListList = GiftEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		giftListList.id = id;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		giftListList.cover = cover;
	}
	final List<String>? images = jsonConvert.convertListNotNull<String>(json['images']);
	if (images != null) {
		giftListList.images = images;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		giftListList.name = name;
	}
	final double? sale = jsonConvert.convert<double>(json['sale']);
	if (sale != null) {
		giftListList.sale = sale;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		giftListList.days = days;
	}
	final int? sendout = jsonConvert.convert<int>(json['sendout']);
	if (sendout != null) {
		giftListList.sendout = sendout;
	}
	final int? own = jsonConvert.convert<int>(json['own']);
	if (own != null) {
		giftListList.own = own;
	}
	final int? maxown = jsonConvert.convert<int>(json['maxown']);
	if (maxown != null) {
		giftListList.maxown = maxown;
	}
	final int? collection = jsonConvert.convert<int>(json['collection']);
	if (collection != null) {
		giftListList.collection = collection;
	}
	return giftListList;
}

Map<String, dynamic> $GiftListListToJson(GiftEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['cover'] = entity.cover;
	data['images'] =  entity.images;
	data['name'] = entity.name;
	data['sale'] = entity.sale;
	data['days'] = entity.days;
	data['sendout'] = entity.sendout;
	data['own'] = entity.own;
	data['maxown'] = entity.maxown;
	data['collection'] = entity.collection;
	return data;
}