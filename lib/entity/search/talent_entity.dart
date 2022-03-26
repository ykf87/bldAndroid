import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/talent_entity.g.dart';


@JsonSerializable()
class TalentEntity {

	TalentEntity();

	factory TalentEntity.fromJson(Map<String, dynamic> json) => $TalentEntityFromJson(json);

	Map<String, dynamic> toJson() => $TalentEntityToJson(this);

  String? nickname;
  String? avatar;
  String? introduce;
  List<String>? album;
  List<TalentCard>? cardList;
  // Map<int, int>? cardMap;
  List<TalentSkill>? skillTagList;
  int? isFollow; //是否关注: 1-关注; 0-未关注
  int? accountId; //用户ID
}

@JsonSerializable()
class TalentCard {

	TalentCard();

	factory TalentCard.fromJson(Map<String, dynamic> json) => $TalentCardFromJson(json);

	Map<String, dynamic> toJson() => $TalentCardToJson(this);

  int? cardType; //1-小红书，2-抖音，3-逛逛
  int? fansNum;
}

@JsonSerializable()
class TalentSkill {

	TalentSkill();

	factory TalentSkill.fromJson(Map<String, dynamic> json) => $TalentSkillFromJson(json);

	Map<String, dynamic> toJson() => $TalentSkillToJson(this);

  int? skillId;
  String? skillLabel;
}
