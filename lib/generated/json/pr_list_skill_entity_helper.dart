import 'package:SDZ/entity/mime/pr_list_skill_entity.dart';

prListSkillEntityFromJson(PrListSkillEntity data, Map<String, dynamic> json) {
	if (json['skillId'] != null) {
		data.skillId = json['skillId'] is String
				? int.tryParse(json['skillId'])
				: json['skillId'].toInt();
	}
	if (json['skillLabel'] != null) {
		data.skillLabel = json['skillLabel'].toString();
	}
	if (json['isSelect'] != null) {
		data.isSelect = json['isSelect'];
	}
	return data;
}

Map<String, dynamic> prListSkillEntityToJson(PrListSkillEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	data['isSelect'] = entity.isSelect;
	return data;
}