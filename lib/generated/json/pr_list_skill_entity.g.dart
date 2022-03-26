import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/pr_list_skill_entity.dart';

PrListSkillEntity $PrListSkillEntityFromJson(Map<String, dynamic> json) {
	final PrListSkillEntity prListSkillEntity = PrListSkillEntity();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		prListSkillEntity.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		prListSkillEntity.skillLabel = skillLabel;
	}
	final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
	if (isSelect != null) {
		prListSkillEntity.isSelect = isSelect;
	}
	return prListSkillEntity;
}

Map<String, dynamic> $PrListSkillEntityToJson(PrListSkillEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	data['isSelect'] = entity.isSelect;
	return data;
}