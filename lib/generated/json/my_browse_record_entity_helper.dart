import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';

myBrowseRecordEntityFromJson(MyBrowseRecordEntity data, Map<String, dynamic> json) {
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
		data.skillTagList = (json['skillTagList'] as List).map((v) => MyBrowseRecordSkillTagList().fromJson(v)).toList();
	}
	if (json['cardList'] != null) {
		data.cardList = (json['cardList'] as List).map((v) => MyCollectEntity().fromJson(v)).toList();
	}
	if (json['introduce'] != null) {
		data.introduce = json['introduce'].toString();
	}
	if (json['album'] != null) {
		data.album = (json['album'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['province'] != null) {
		data.province = json['province'].toString();
	}
	if (json['city'] != null) {
		data.city = json['city'].toString();
	}
	if (json['isFollow'] != null) {
		data.follow = json['isFollow'] is String
				? int.tryParse(json['isFollow'])
				: json['isFollow'].toInt();
	}
	if (json['isPlaySvg'] != null) {
		data.isPlaySvg = json['isPlaySvg'];
	}
	return data;
}

Map<String, dynamic> myBrowseRecordEntityToJson(MyBrowseRecordEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['accountId'] = entity.accountId;
	data['skillTagList'] =  entity.skillTagList?.map((v) => v.toJson())?.toList();
	data['cardList'] =  entity.cardList?.map((v) => v.toJson())?.toList();
	data['introduce'] = entity.introduce;
	data['album'] = entity.album;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['isFollow'] = entity.follow;
	data['isPlaySvg'] = entity.isPlaySvg;
	return data;
}

myBrowseRecordSkillTagListFromJson(MyBrowseRecordSkillTagList data, Map<String, dynamic> json) {
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

Map<String, dynamic> myBrowseRecordSkillTagListToJson(MyBrowseRecordSkillTagList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}