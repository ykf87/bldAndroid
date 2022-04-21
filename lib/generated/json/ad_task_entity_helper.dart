import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/res/colors.dart';
import 'package:flutter/cupertino.dart';

adTaskEntityFromJson(AdTaskEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['max'] != null) {
		data.max = json['max'] is String
				? int.tryParse(json['max'])
				: json['max'].toInt();
	}
	if (json['min'] != null) {
		data.min = json['min'] is String
				? int.tryParse(json['min'])
				: json['min'].toInt();
	}
	if (json['prize'] != null) {
		data.prize = json['prize'] is String
				? int.tryParse(json['prize'])
				: json['prize'].toInt();
	}
	if (json['times'] != null) {
		data.times = json['times'] is String
				? int.tryParse(json['times'])
				: json['times'].toInt();
	}
	if (json['videoId'] != null) {
		data.videoId = json['videoId'].toString();
	}
	if (json['resType'] != null) {
		data.resType = json['resType'] is String
				? int.tryParse(json['resType'])
				: json['resType'].toInt();
	}
	if (json['platform'] != null) {
		data.platform = json['platform'] is String
				? int.tryParse(json['platform'])
				: json['platform'].toInt();
	}
	return data;
}

Map<String, dynamic> adTaskEntityToJson(AdTaskEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['max'] = entity.max;
	data['min'] = entity.min;
	data['prize'] = entity.prize;
	data['times'] = entity.times;
	data['videoId'] = entity.videoId;
	data['resType'] = entity.resType;
	data['platform'] = entity.platform;
	return data;
}