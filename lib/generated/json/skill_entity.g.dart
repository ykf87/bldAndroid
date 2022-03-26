import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/skill_entity.dart';

SkillEntity $SkillEntityFromJson(Map<String, dynamic> json) {
	final SkillEntity skillEntity = SkillEntity();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		skillEntity.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		skillEntity.skillLabel = skillLabel;
	}
	final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
	if (isSelect != null) {
		skillEntity.isSelect = isSelect;
	}
	return skillEntity;
}

Map<String, dynamic> $SkillEntityToJson(SkillEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	data['isSelect'] = entity.isSelect;
	return data;
}