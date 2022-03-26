import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';


MyBrowseRecordEntity $MyBrowseRecordEntityFromJson(Map<String, dynamic> json) {
	final MyBrowseRecordEntity myBrowseRecordEntity = MyBrowseRecordEntity();
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		myBrowseRecordEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		myBrowseRecordEntity.avatar = avatar;
	}
	final int? accountId = jsonConvert.convert<int>(json['accountId']);
	if (accountId != null) {
		myBrowseRecordEntity.accountId = accountId;
	}
	final List<MyBrowseRecordSkillTagList>? skillTagList = jsonConvert.convertListNotNull<MyBrowseRecordSkillTagList>(json['skillTagList']);
	if (skillTagList != null) {
		myBrowseRecordEntity.skillTagList = skillTagList;
	}
	final List<MyCollectEntity>? cardList = jsonConvert.convertListNotNull<MyCollectEntity>(json['cardList']);
	if (cardList != null) {
		myBrowseRecordEntity.cardList = cardList;
	}
	final String? introduce = jsonConvert.convert<String>(json['introduce']);
	if (introduce != null) {
		myBrowseRecordEntity.introduce = introduce;
	}
	final List<String>? album = jsonConvert.convertListNotNull<String>(json['album']);
	if (album != null) {
		myBrowseRecordEntity.album = album;
	}
	final String? province = jsonConvert.convert<String>(json['province']);
	if (province != null) {
		myBrowseRecordEntity.province = province;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		myBrowseRecordEntity.city = city;
	}
	final int? follow = jsonConvert.convert<int>(json['isFollow']);
	if (follow != null) {
		myBrowseRecordEntity.follow = follow;
	}
	final bool? isPlaySvg = jsonConvert.convert<bool>(json['isPlaySvg']);
	if (isPlaySvg != null) {
		myBrowseRecordEntity.isPlaySvg = isPlaySvg;
	}
	return myBrowseRecordEntity;
}

Map<String, dynamic> $MyBrowseRecordEntityToJson(MyBrowseRecordEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['accountId'] = entity.accountId;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson()).toList();
	data['cardList'] =  entity.cardList?.map((v) => v.toJson()).toList();
	data['introduce'] = entity.introduce;
	data['album'] =  entity.album;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['isFollow'] = entity.follow;
	data['isPlaySvg'] = entity.isPlaySvg;
	return data;
}

MyBrowseRecordSkillTagList $MyBrowseRecordSkillTagListFromJson(Map<String, dynamic> json) {
	final MyBrowseRecordSkillTagList myBrowseRecordSkillTagList = MyBrowseRecordSkillTagList();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		myBrowseRecordSkillTagList.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		myBrowseRecordSkillTagList.skillLabel = skillLabel;
	}
	return myBrowseRecordSkillTagList;
}

Map<String, dynamic> $MyBrowseRecordSkillTagListToJson(MyBrowseRecordSkillTagList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}