import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/search/card_entity.dart';

CardEntity $CardEntityFromJson(Map<String, dynamic> json) {
	final CardEntity cardEntity = CardEntity();
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		cardEntity.total = total;
	}
	final List<CardItemEntity>? cardList = jsonConvert.convertListNotNull<CardItemEntity>(json['cardList']);
	if (cardList != null) {
		cardEntity.cardList = cardList;
	}
	return cardEntity;
}

Map<String, dynamic> $CardEntityToJson(CardEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total'] = entity.total;
	data['cardList'] =  entity.cardList?.map((v) => v.toJson()).toList();
	return data;
}

CardItemEntity $CardItemEntityFromJson(Map<String, dynamic> json) {
	final CardItemEntity cardItemEntity = CardItemEntity();
	final int? cardType = jsonConvert.convert<int>(json['cardType']);
	if (cardType != null) {
		cardItemEntity.cardType = cardType;
	}
	final String? cardName = jsonConvert.convert<String>(json['cardName']);
	if (cardName != null) {
		cardItemEntity.cardName = cardName;
	}
	final int? cardId = jsonConvert.convert<int>(json['cardId']);
	if (cardId != null) {
		cardItemEntity.cardId = cardId;
	}
	final int? accountId = jsonConvert.convert<int>(json['accountId']);
	if (accountId != null) {
		cardItemEntity.accountId = accountId;
	}
	final String? cardAvatar = jsonConvert.convert<String>(json['cardAvatar']);
	if (cardAvatar != null) {
		cardItemEntity.cardAvatar = cardAvatar;
	}
	final int? likesNum = jsonConvert.convert<int>(json['likesNum']);
	if (likesNum != null) {
		cardItemEntity.likesNum = likesNum;
	}
	final int? fansNum = jsonConvert.convert<int>(json['fansNum']);
	if (fansNum != null) {
		cardItemEntity.fansNum = fansNum;
	}
	final int? avgLikeNum = jsonConvert.convert<int>(json['avgLikeNum']);
	if (avgLikeNum != null) {
		cardItemEntity.avgLikeNum = avgLikeNum;
	}
	final List<SkillTagItemEntity>? skillTagList = jsonConvert.convertListNotNull<SkillTagItemEntity>(json['skillTagList']);
	if (skillTagList != null) {
		cardItemEntity.skillTagList = skillTagList;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		cardItemEntity.gender = gender;
	}
	return cardItemEntity;
}

Map<String, dynamic> $CardItemEntityToJson(CardItemEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cardType'] = entity.cardType;
	data['cardName'] = entity.cardName;
	data['cardId'] = entity.cardId;
	data['accountId'] = entity.accountId;
	data['cardAvatar'] = entity.cardAvatar;
	data['likesNum'] = entity.likesNum;
	data['fansNum'] = entity.fansNum;
	data['avgLikeNum'] = entity.avgLikeNum;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson()).toList();
	data['gender'] = entity.gender;
	return data;
}

SkillTagItemEntity $SkillTagItemEntityFromJson(Map<String, dynamic> json) {
	final SkillTagItemEntity skillTagItemEntity = SkillTagItemEntity();
	final double? skillId = jsonConvert.convert<double>(json['skillId']);
	if (skillId != null) {
		skillTagItemEntity.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		skillTagItemEntity.skillLabel = skillLabel;
	}
	return skillTagItemEntity;
}

Map<String, dynamic> $SkillTagItemEntityToJson(SkillTagItemEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}