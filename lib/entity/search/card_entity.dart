import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/card_entity.g.dart';


@JsonSerializable()
class CardEntity {

	CardEntity();

	factory CardEntity.fromJson(Map<String, dynamic> json) => $CardEntityFromJson(json);

	Map<String, dynamic> toJson() => $CardEntityToJson(this);

	int? total;
	List<CardItemEntity>? cardList;
}

@JsonSerializable()
class CardItemEntity {

	CardItemEntity();

	factory CardItemEntity.fromJson(Map<String, dynamic> json) => $CardItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $CardItemEntityToJson(this);

	int? cardType;
	String? cardName;
	int? cardId;
	int? accountId;
	String? cardAvatar;
	int? likesNum;
	int? fansNum;
	int? avgLikeNum;
	List<SkillTagItemEntity>? skillTagList;
	int? gender;
}

@JsonSerializable()
class SkillTagItemEntity {

	SkillTagItemEntity();

	factory SkillTagItemEntity.fromJson(Map<String, dynamic> json) => $SkillTagItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $SkillTagItemEntityToJson(this);

	double? skillId;
	String? skillLabel;
}
