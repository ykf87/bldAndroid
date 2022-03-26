import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/pr_list_skill_entity.g.dart';


@JsonSerializable()
class PrListSkillEntity {

	PrListSkillEntity();

	factory PrListSkillEntity.fromJson(Map<String, dynamic> json) => $PrListSkillEntityFromJson(json);

	Map<String, dynamic> toJson() => $PrListSkillEntityToJson(this);

	late int skillId;
	late String skillLabel;
	late bool isSelect = false;
}
