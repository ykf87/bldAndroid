import 'package:SDZ/generated/json/base/json_convert_content.dart';

class CardEntity with JsonConvert<CardEntity> {
	int? total;
	List<CardItemEntity>? cardList;
}

class CardItemEntity with JsonConvert<CardItemEntity> {
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

class SkillTagItemEntity with JsonConvert<SkillTagItemEntity> {
	double? skillId;
	String? skillLabel;
}
