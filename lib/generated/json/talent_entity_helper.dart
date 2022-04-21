import 'package:SDZ/entity/search/talent_entity.dart';

talentEntityFromJson(TalentEntity data, Map<String, dynamic> json) {
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['introduce'] != null) {
		data.introduce = json['introduce'].toString();
	}
	if (json['album'] != null) {
		data.album = (json['album'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['cardList'] != null) {
		data.cardList = (json['cardList'] as List).map((v) => TalentCard().fromJson(v)).toList();
	}
	if (json['skillTagList'] != null) {
		data.skillTagList = (json['skillTagList'] as List).map((v) => TalentSkill().fromJson(v)).toList();
	}
	if (json['isFollow'] != null) {
		data.isFollow = json['isFollow'] is String
				? int.tryParse(json['isFollow'])
				: json['isFollow'].toInt();
	}
	if (json['accountId'] != null) {
		data.accountId = json['accountId'] is String
				? int.tryParse(json['accountId'])
				: json['accountId'].toInt();
	}
	return data;
}

Map<String, dynamic> talentEntityToJson(TalentEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['introduce'] = entity.introduce;
	data['album'] = entity.album;
	data['cardList'] =  entity.cardList?.map((v) => v.toJson())?.toList();
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson())?.toList();
	data['isFollow'] = entity.isFollow;
	data['accountId'] = entity.accountId;
	return data;
}

talentCardFromJson(TalentCard data, Map<String, dynamic> json) {
	if (json['cardType'] != null) {
		data.cardType = json['cardType'] is String
				? int.tryParse(json['cardType'])
				: json['cardType'].toInt();
	}
	if (json['fansNum'] != null) {
		data.fansNum = json['fansNum'] is String
				? int.tryParse(json['fansNum'])
				: json['fansNum'].toInt();
	}
	return data;
}

Map<String, dynamic> talentCardToJson(TalentCard entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cardType'] = entity.cardType;
	data['fansNum'] = entity.fansNum;
	return data;
}

talentSkillFromJson(TalentSkill data, Map<String, dynamic> json) {
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

Map<String, dynamic> talentSkillToJson(TalentSkill entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}