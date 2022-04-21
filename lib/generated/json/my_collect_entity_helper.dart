import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/utils/utils.dart';

myCollectEntityFromJson(MyCollectEntity data, Map<String, dynamic> json) {
	if (json['cardType'] != null) {
		data.cardType = json['cardType'] is String
				? int.tryParse(json['cardType'])
				: json['cardType'].toInt();
	}
	if (json['cardName'] != null) {
		data.cardName = json['cardName'].toString();
	}
	if (json['cardAvatar'] != null) {
		data.cardAvatar = json['cardAvatar'].toString();
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
		data.skillTagList = (json['skillTagList'] as List).map((v) => MyCollectSkillTagList().fromJson(v)).toList();
	}
	if (json['skills'] != null) {
		data.skills = (json['skills'] as List).map((v) => MyCollectSkillTagList().fromJson(v)).toList();
	}
	if (json['cardWorks'] != null) {
		data.cardWorks = (json['cardWorks'] as List).map((v) => CardWoksList().fromJson(v)).toList();
	}
	if (json['gender'] != null) {
		data.gender = json['gender'] is String
				? int.tryParse(json['gender'])
				: json['gender'].toInt();
	}
	if (json['detailInfo'] != null) {
		data.detailInfo = json['detailInfo'].toString();
	}
	if (json['province'] != null) {
		data.province = json['province'].toString();
	}
	if (json['city'] != null) {
		data.city = json['city'].toString();
	}
	if (json['headImageUrl'] != null) {
		data.headImageUrl = json['headImageUrl'].toString();
	}
	if (json['followNum'] != null) {
		data.followNum = json['followNum'] is String
				? int.tryParse(json['followNum'])
				: json['followNum'].toInt();
	}
	if (json['isCollection'] != null) {
		data.isCollection = json['isCollection'] is String
				? int.tryParse(json['isCollection'])
				: json['isCollection'].toInt();
	}
	return data;
}

Map<String, dynamic> myCollectEntityToJson(MyCollectEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cardType'] = entity.cardType;
	data['cardName'] = entity.cardName;
	data['cardAvatar'] = entity.cardAvatar;
	data['cardId'] = entity.cardId;
	data['accountId'] = entity.accountId;
	data['likesNum'] = entity.likesNum;
	data['fansNum'] = entity.fansNum;
	data['avgLikeNum'] = entity.avgLikeNum;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson())?.toList();
	data['skills'] =  entity.skills?.map((v) => v.toJson())?.toList();
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

myCollectSkillTagListFromJson(MyCollectSkillTagList data, Map<String, dynamic> json) {
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

Map<String, dynamic> myCollectSkillTagListToJson(MyCollectSkillTagList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}

cardWoksListFromJson(CardWoksList data, Map<String, dynamic> json) {
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['indexImgUrl'] != null) {
		data.indexImgUrl = json['indexImgUrl'].toString();
	}
	if (json['likeNum'] != null) {
		data.likeNum = json['likeNum'] is String
				? int.tryParse(json['likeNum'])
				: json['likeNum'].toInt();
	}
	return data;
}

Map<String, dynamic> cardWoksListToJson(CardWoksList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['title'] = entity.title;
	data['indexImgUrl'] = entity.indexImgUrl;
	data['likeNum'] = entity.likeNum;
	return data;
}