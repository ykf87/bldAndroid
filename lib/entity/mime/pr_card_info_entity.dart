import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/pr_card_info_entity.g.dart';

///PR名片
@JsonSerializable()
class PrCardInfoEntity {

	PrCardInfoEntity();

	factory PrCardInfoEntity.fromJson(Map<String, dynamic> json) => $PrCardInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $PrCardInfoEntityToJson(this);

	late int identityType;
	late String companyName;
	late String professionalTitle;
	late String cardAvatar;
	late List<PrCardInfoSkills> skills;
	 int? status;//认证状态: 1未认证、2认证中、3已认证
	 String? remark;
}

@JsonSerializable()
class PrCardInfoSkills {

	PrCardInfoSkills();

	factory PrCardInfoSkills.fromJson(Map<String, dynamic> json) => $PrCardInfoSkillsFromJson(json);

	Map<String, dynamic> toJson() => $PrCardInfoSkillsToJson(this);

	 int skillId = 0;
	late String skillLabel;
}
