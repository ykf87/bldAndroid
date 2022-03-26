import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/search/talent_entity.dart';

TalentEntity $TalentEntityFromJson(Map<String, dynamic> json) {
	final TalentEntity talentEntity = TalentEntity();
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		talentEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		talentEntity.avatar = avatar;
	}
	final String? introduce = jsonConvert.convert<String>(json['introduce']);
	if (introduce != null) {
		talentEntity.introduce = introduce;
	}
	final List<String>? album = jsonConvert.convertListNotNull<String>(json['album']);
	if (album != null) {
		talentEntity.album = album;
	}
	final List<TalentCard>? cardList = jsonConvert.convertListNotNull<TalentCard>(json['cardList']);
	if (cardList != null) {
		talentEntity.cardList = cardList;
	}
	final List<TalentSkill>? skillTagList = jsonConvert.convertListNotNull<TalentSkill>(json['skillTagList']);
	if (skillTagList != null) {
		talentEntity.skillTagList = skillTagList;
	}
	final int? isFollow = jsonConvert.convert<int>(json['isFollow']);
	if (isFollow != null) {
		talentEntity.isFollow = isFollow;
	}
	final int? accountId = jsonConvert.convert<int>(json['accountId']);
	if (accountId != null) {
		talentEntity.accountId = accountId;
	}
	return talentEntity;
}

Map<String, dynamic> $TalentEntityToJson(TalentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['introduce'] = entity.introduce;
	data['album'] =  entity.album;
	data['cardList'] =  entity.cardList?.map((v) => v.toJson()).toList();
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson()).toList();
	data['isFollow'] = entity.isFollow;
	data['accountId'] = entity.accountId;
	return data;
}

TalentCard $TalentCardFromJson(Map<String, dynamic> json) {
	final TalentCard talentCard = TalentCard();
	final int? cardType = jsonConvert.convert<int>(json['cardType']);
	if (cardType != null) {
		talentCard.cardType = cardType;
	}
	final int? fansNum = jsonConvert.convert<int>(json['fansNum']);
	if (fansNum != null) {
		talentCard.fansNum = fansNum;
	}
	return talentCard;
}

Map<String, dynamic> $TalentCardToJson(TalentCard entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cardType'] = entity.cardType;
	data['fansNum'] = entity.fansNum;
	return data;
}

TalentSkill $TalentSkillFromJson(Map<String, dynamic> json) {
	final TalentSkill talentSkill = TalentSkill();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		talentSkill.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		talentSkill.skillLabel = skillLabel;
	}
	return talentSkill;
}

Map<String, dynamic> $TalentSkillToJson(TalentSkill entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}