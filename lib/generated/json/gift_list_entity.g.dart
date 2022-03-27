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

GiftEntity $GiftEntityFromJson(Map<String, dynamic> json) {
	final GiftEntity giftEntity = GiftEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		giftEntity.id = id;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		giftEntity.cover = cover;
	}
	final List<String>? images = jsonConvert.convertListNotNull<String>(json['images']);
	if (images != null) {
		giftEntity.images = images;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		giftEntity.name = name;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		giftEntity.title = title;
	}
	final double? sale = jsonConvert.convert<double>(json['sale']);
	if (sale != null) {
		giftEntity.sale = sale;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		giftEntity.days = days;
	}
	final int? sendout = jsonConvert.convert<int>(json['sendout']);
	if (sendout != null) {
		giftEntity.sendout = sendout;
	}
	final int? own = jsonConvert.convert<int>(json['own']);
	if (own != null) {
		giftEntity.own = own;
	}
	final int? maxown = jsonConvert.convert<int>(json['maxown']);
	if (maxown != null) {
		giftEntity.maxown = maxown;
	}
	final int? collection = jsonConvert.convert<int>(json['collection']);
	if (collection != null) {
		giftEntity.collection = collection;
	}
	return giftEntity;
}

Map<String, dynamic> $GiftEntityToJson(GiftEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['cover'] = entity.cover;
	data['images'] =  entity.images;
	data['name'] = entity.name;
	data['title'] = entity.title;
	data['sale'] = entity.sale;
	data['days'] = entity.days;
	data['sendout'] = entity.sendout;
	data['own'] = entity.own;
	data['maxown'] = entity.maxown;
	data['collection'] = entity.collection;
	return data;
}