import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';

MyFocusTalentEntity $MyFocusTalentEntityFromJson(Map<String, dynamic> json) {
	final MyFocusTalentEntity myFocusTalentEntity = MyFocusTalentEntity();
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		myFocusTalentEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		myFocusTalentEntity.avatar = avatar;
	}
	final int? accountId = jsonConvert.convert<int>(json['accountId']);
	if (accountId != null) {
		myFocusTalentEntity.accountId = accountId;
	}
	final List<MyFocusTalentSkillTagList>? skillTagList = jsonConvert.convertListNotNull<MyFocusTalentSkillTagList>(json['skillTagList']);
	if (skillTagList != null) {
		myFocusTalentEntity.skillTagList = skillTagList;
	}
	final List<MyFocusTalentCardList>? cardList = jsonConvert.convertListNotNull<MyFocusTalentCardList>(json['cardList']);
	if (cardList != null) {
		myFocusTalentEntity.cardList = cardList;
	}
	return myFocusTalentEntity;
}

Map<String, dynamic> $MyFocusTalentEntityToJson(MyFocusTalentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['accountId'] = entity.accountId;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson()).toList();
	data['cardList'] =  entity.cardList?.map((v) => v.toJson()).toList();
	return data;
}

MyFocusTalentSkillTagList $MyFocusTalentSkillTagListFromJson(Map<String, dynamic> json) {
	final MyFocusTalentSkillTagList myFocusTalentSkillTagList = MyFocusTalentSkillTagList();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		myFocusTalentSkillTagList.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		myFocusTalentSkillTagList.skillLabel = skillLabel;
	}
	return myFocusTalentSkillTagList;
}

Map<String, dynamic> $MyFocusTalentSkillTagListToJson(MyFocusTalentSkillTagList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}

MyFocusTalentCardList $MyFocusTalentCardListFromJson(Map<String, dynamic> json) {
	final MyFocusTalentCardList myFocusTalentCardList = MyFocusTalentCardList();
	final int? cardType = jsonConvert.convert<int>(json['cardType']);
	if (cardType != null) {
		myFocusTalentCardList.cardType = cardType;
	}
	final String? fansNum = jsonConvert.convert<String>(json['fansNum']);
	if (fansNum != null) {
		myFocusTalentCardList.fansNum = fansNum;
	}
	return myFocusTalentCardList;
}

Map<String, dynamic> $MyFocusTalentCardListToJson(MyFocusTalentCardList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cardType'] = entity.cardType;
	data['fansNum'] = entity.fansNum;
	return data;
}