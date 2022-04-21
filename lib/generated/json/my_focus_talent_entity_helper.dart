import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';

myFocusTalentEntityFromJson(MyFocusTalentEntity data, Map<String, dynamic> json) {
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['accountId'] != null) {
		data.accountId = json['accountId'] is String
				? int.tryParse(json['accountId'])
				: json['accountId'].toInt();
	}
	if (json['skillTagList'] != null) {
		data.skillTagList = (json['skillTagList'] as List).map((v) => MyFocusTalentSkillTagList().fromJson(v)).toList();
	}
	if (json['cardList'] != null) {
		data.cardList = (json['cardList'] as List).map((v) => MyFocusTalentCardList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> myFocusTalentEntityToJson(MyFocusTalentEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['accountId'] = entity.accountId;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson())?.toList();
	data['cardList'] =  entity.cardList?.map((v) => v.toJson())?.toList();
	return data;
}

myFocusTalentSkillTagListFromJson(MyFocusTalentSkillTagList data, Map<String, dynamic> json) {
	if (json['skillId'] != null) {
		data.skillId = json['skillId'] is String
				? int.tryParse(json['skillId'])
				: json['skillId'].toInt();
	}
	if (json['skillLabel'] != null) {
		data.skillLabel = json['skillLabel'].toString();
	}
	return data;
}

Map<String, dynamic> myFocusTalentSkillTagListToJson(MyFocusTalentSkillTagList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}

myFocusTalentCardListFromJson(MyFocusTalentCardList data, Map<String, dynamic> json) {
	if (json['cardType'] != null) {
		data.cardType = json['cardType'] is String
				? int.tryParse(json['cardType'])
				: json['cardType'].toInt();
	}
	if (json['fansNum'] != null) {
		data.fansNum = json['fansNum'].toString();
	}
	return data;
}

Map<String, dynamic> myFocusTalentCardListToJson(MyFocusTalentCardList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cardType'] = entity.cardType;
	data['fansNum'] = entity.fansNum;
	return data;
}