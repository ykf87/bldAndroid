import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/utils/utils.dart';


MyCollectEntity $MyCollectEntityFromJson(Map<String, dynamic> json) {
	final MyCollectEntity myCollectEntity = MyCollectEntity();
	final int? cardType = jsonConvert.convert<int>(json['cardType']);
	if (cardType != null) {
		myCollectEntity.cardType = cardType;
	}
	final String? cardName = jsonConvert.convert<String>(json['cardName']);
	if (cardName != null) {
		myCollectEntity.cardName = cardName;
	}
	final String? cardAvatar = jsonConvert.convert<String>(json['cardAvatar']);
	if (cardAvatar != null) {
		myCollectEntity.cardAvatar = cardAvatar;
	}
	final int? cardId = jsonConvert.convert<int>(json['cardId']);
	if (cardId != null) {
		myCollectEntity.cardId = cardId;
	}
	final int? accountId = jsonConvert.convert<int>(json['accountId']);
	if (accountId != null) {
		myCollectEntity.accountId = accountId;
	}
	final int? likesNum = jsonConvert.convert<int>(json['likesNum']);
	if (likesNum != null) {
		myCollectEntity.likesNum = likesNum;
	}
	final int? fansNum = jsonConvert.convert<int>(json['fansNum']);
	if (fansNum != null) {
		myCollectEntity.fansNum = fansNum;
	}
	final int? avgLikeNum = jsonConvert.convert<int>(json['avgLikeNum']);
	if (avgLikeNum != null) {
		myCollectEntity.avgLikeNum = avgLikeNum;
	}
	final List<MyCollectSkillTagList>? skillTagList = jsonConvert.convertListNotNull<MyCollectSkillTagList>(json['skillTagList']);
	if (skillTagList != null) {
		myCollectEntity.skillTagList = skillTagList;
	}
	final List<MyCollectSkillTagList>? skills = jsonConvert.convertListNotNull<MyCollectSkillTagList>(json['skills']);
	if (skills != null) {
		myCollectEntity.skills = skills;
	}
	final List<CardWoksList>? cardWorks = jsonConvert.convertListNotNull<CardWoksList>(json['cardWorks']);
	if (cardWorks != null) {
		myCollectEntity.cardWorks = cardWorks;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		myCollectEntity.gender = gender;
	}
	final String? detailInfo = jsonConvert.convert<String>(json['detailInfo']);
	if (detailInfo != null) {
		myCollectEntity.detailInfo = detailInfo;
	}
	final String? province = jsonConvert.convert<String>(json['province']);
	if (province != null) {
		myCollectEntity.province = province;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		myCollectEntity.city = city;
	}
	final String? headImageUrl = jsonConvert.convert<String>(json['headImageUrl']);
	if (headImageUrl != null) {
		myCollectEntity.headImageUrl = headImageUrl;
	}
	final int? followNum = jsonConvert.convert<int>(json['followNum']);
	if (followNum != null) {
		myCollectEntity.followNum = followNum;
	}
	final int? isCollection = jsonConvert.convert<int>(json['isCollection']);
	if (isCollection != null) {
		myCollectEntity.isCollection = isCollection;
	}
	return myCollectEntity;
}

Map<String, dynamic> $MyCollectEntityToJson(MyCollectEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cardType'] = entity.cardType;
	data['cardName'] = entity.cardName;
	data['cardAvatar'] = entity.cardAvatar;
	data['cardId'] = entity.cardId;
	data['accountId'] = entity.accountId;
	data['likesNum'] = entity.likesNum;
	data['fansNum'] = entity.fansNum;
	data['avgLikeNum'] = entity.avgLikeNum;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson()).toList();
	data['skills'] =  entity.skills?.map((v) => v.toJson()).toList();
	data['cardWorks'] =  entity.cardWorks.map((v) => v.toJson()).toList();
	data['gender'] = entity.gender;
	data['detailInfo'] = entity.detailInfo;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['headImageUrl'] = entity.headImageUrl;
	data['followNum'] = entity.followNum;
	data['isCollection'] = entity.isCollection;
	return data;
}

MyCollectSkillTagList $MyCollectSkillTagListFromJson(Map<String, dynamic> json) {
	final MyCollectSkillTagList myCollectSkillTagList = MyCollectSkillTagList();
	final double? skillId = jsonConvert.convert<double>(json['skillId']);
	if (skillId != null) {
		myCollectSkillTagList.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		myCollectSkillTagList.skillLabel = skillLabel;
	}
	return myCollectSkillTagList;
}

Map<String, dynamic> $MyCollectSkillTagListToJson(MyCollectSkillTagList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}

CardWoksList $CardWoksListFromJson(Map<String, dynamic> json) {
	final CardWoksList cardWoksList = CardWoksList();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		cardWoksList.title = title;
	}
	final String? indexImgUrl = jsonConvert.convert<String>(json['indexImgUrl']);
	if (indexImgUrl != null) {
		cardWoksList.indexImgUrl = indexImgUrl;
	}
	final int? likeNum = jsonConvert.convert<int>(json['likeNum']);
	if (likeNum != null) {
		cardWoksList.likeNum = likeNum;
	}
	return cardWoksList;
}

Map<String, dynamic> $CardWoksListToJson(CardWoksList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['indexImgUrl'] = entity.indexImgUrl;
	data['likeNum'] = entity.likeNum;
	return data;
}