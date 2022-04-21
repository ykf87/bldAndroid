import 'package:SDZ/entity/search/card_entity.dart';

cardEntityFromJson(CardEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	if (json['cardList'] != null) {
		data.cardList = (json['cardList'] as List).map((v) => CardItemEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> cardEntityToJson(CardEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	data['cardList'] =  entity.cardList?.map((v) => v.toJson())?.toList();
	return data;
}

cardItemEntityFromJson(CardItemEntity data, Map<String, dynamic> json) {
	if (json['cardType'] != null) {
		data.cardType = json['cardType'] is String
				? int.tryParse(json['cardType'])
				: json['cardType'].toInt();
	}
	if (json['cardName'] != null) {
		data.cardName = json['cardName'].toString();
	}
	if (json['cardId'] != null) {
		data.cardId = json['cardId'] is String
				? int.tryParse(json['cardId'])
				: json['cardId'].toInt();
	}
	if (json['accountId'] != null) {
		data.accountId = json['accountId'] is String
				? int.tryParse(json['accountId'])
				: json['accountId'].toInt();
	}
	if (json['cardAvatar'] != null) {
		data.cardAvatar = json['cardAvatar'].toString();
	}
	if (json['likesNum'] != null) {
		data.likesNum = json['likesNum'] is String
				? int.tryParse(json['likesNum'])
				: json['likesNum'].toInt();
	}
	if (json['fansNum'] != null) {
		data.fansNum = json['fansNum'] is String
				? int.tryParse(json['fansNum'])
				: json['fansNum'].toInt();
	}
	if (json['avgLikeNum'] != null) {
		data.avgLikeNum = json['avgLikeNum'] is String
				? int.tryParse(json['avgLikeNum'])
				: json['avgLikeNum'].toInt();
	}
	if (json['skillTagList'] != null) {
		data.skillTagList = (json['skillTagList'] as List).map((v) => SkillTagItemEntity().fromJson(v)).toList();
	}
	if (json['gender'] != null) {
		data.gender = json['gender'] is String
				? int.tryParse(json['gender'])
				: json['gender'].toInt();
	}
	return data;
}

Map<String, dynamic> cardItemEntityToJson(CardItemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cardType'] = entity.cardType;
	data['cardName'] = entity.cardName;
	data['cardId'] = entity.cardId;
	data['accountId'] = entity.accountId;
	data['cardAvatar'] = entity.cardAvatar;
	data['likesNum'] = entity.likesNum;
	data['fansNum'] = entity.fansNum;
	data['avgLikeNum'] = entity.avgLikeNum;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson())?.toList();
	data['gender'] = entity.gender;
	return data;
}

skillTagItemEntityFromJson(SkillTagItemEntity data, Map<String, dynamic> json) {
	if (json['skillId'] != null) {
		data.skillId = json['skillId'] is String
				? double.tryParse(json['skillId'])
				: json['skillId'].toDouble();
	}
	if (json['skillLabel'] != null) {
		data.skillLabel = json['skillLabel'].toString();
	}
	return data;
}

Map<String, dynamic> skillTagItemEntityToJson(SkillTagItemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}