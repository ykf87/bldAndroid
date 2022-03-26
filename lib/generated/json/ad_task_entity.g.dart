import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/res/colors.dart';

import 'package:flutter/cupertino.dart';


AdTaskEntity $AdTaskEntityFromJson(Map<String, dynamic> json) {
	final AdTaskEntity adTaskEntity = AdTaskEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		adTaskEntity.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		adTaskEntity.title = title;
	}
	final int? max = jsonConvert.convert<int>(json['max']);
	if (max != null) {
		adTaskEntity.max = max;
	}
	final int? min = jsonConvert.convert<int>(json['min']);
	if (min != null) {
		adTaskEntity.min = min;
	}
	final int? prize = jsonConvert.convert<int>(json['prize']);
	if (prize != null) {
		adTaskEntity.prize = prize;
	}
	final int? times = jsonConvert.convert<int>(json['times']);
	if (times != null) {
		adTaskEntity.times = times;
	}
	final String? videoId = jsonConvert.convert<String>(json['videoId']);
	if (videoId != null) {
		adTaskEntity.videoId = videoId;
	}
	final int? resType = jsonConvert.convert<int>(json['resType']);
	if (resType != null) {
		adTaskEntity.resType = resType;
	}
	final int? platform = jsonConvert.convert<int>(json['platform']);
	if (platform != null) {
		adTaskEntity.platform = platform;
	}
	return adTaskEntity;
}

Map<String, dynamic> $AdTaskEntityToJson(AdTaskEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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