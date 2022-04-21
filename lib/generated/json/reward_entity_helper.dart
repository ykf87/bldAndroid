import 'package:SDZ/page/mime/entity/reward_entity.dart';

rewardEntityFromJson(RewardEntity data, Map<String, dynamic> json) {
	if (json['task'] != null) {
		data.task = RewardTask().fromJson(json['task']);
	}
	if (json['jifen'] != null) {
		data.jifen = json['jifen'] is String
				? int.tryParse(json['jifen'])
				: json['jifen'].toInt();
	}
	return data;
}

Map<String, dynamic> rewardEntityToJson(RewardEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['task'] = entity.task?.toJson();
	data['jifen'] = entity.jifen;
	return data;
}

rewardTaskFromJson(RewardTask data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> rewardTaskToJson(RewardTask entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['max'] = entity.max;
	data['min'] = entity.min;
	data['prize'] = entity.prize;
	data['times'] = entity.times;
	return data;
}