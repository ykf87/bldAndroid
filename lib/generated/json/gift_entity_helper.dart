import 'package:SDZ/entity/sign/gift_entity.dart';

giftEntityFromJson(GiftEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['sale'] != null) {
		data.sale = json['sale'] is String
				? double.tryParse(json['sale'])
				: json['sale'].toDouble();
	}
	if (json['sendout'] != null) {
		data.sendout = json['sendout'] is String
				? int.tryParse(json['sendout'])
				: json['sendout'].toInt();
	}
	if (json['own'] != null) {
		data.own = json['own'] is String
				? int.tryParse(json['own'])
				: json['own'].toInt();
	}
	if (json['maxown'] != null) {
		data.maxown = json['maxown'] is String
				? int.tryParse(json['maxown'])
				: json['maxown'].toInt();
	}
	if (json['images'] != null) {
		data.images = (json['images'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['days'] != null) {
		data.days = json['days'] is String
				? int.tryParse(json['days'])
				: json['days'].toInt();
	}
	if (json['collection'] != null) {
		data.collection = json['collection'] is String
				? int.tryParse(json['collection'])
				: json['collection'].toInt();
	}
	if (json['isAd'] != null) {
		data.isAd = json['isAd'];
	}
	return data;
}

Map<String, dynamic> giftEntityToJson(GiftEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['cover'] = entity.cover;
	data['sale'] = entity.sale;
	data['sendout'] = entity.sendout;
	data['own'] = entity.own;
	data['maxown'] = entity.maxown;
	data['images'] = entity.images;
	data['title'] = entity.title;
	data['days'] = entity.days;
	data['collection'] = entity.collection;
	data['isAd'] = entity.isAd;
	return data;
}