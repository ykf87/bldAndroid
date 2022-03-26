import 'package:SDZ/entity/mime/bank_entity.dart';
import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';

UserCenterEntity $UserCenterEntityFromJson(Map<String, dynamic> json) {
	final UserCenterEntity userCenterEntity = UserCenterEntity();
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userCenterEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		userCenterEntity.avatar = avatar;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		userCenterEntity.phone = phone;
	}
	final int? followsCount = jsonConvert.convert<int>(json['followsCount']);
	if (followsCount != null) {
		userCenterEntity.followsCount = followsCount;
	}
	final int? viewCount = jsonConvert.convert<int>(json['viewCount']);
	if (viewCount != null) {
		userCenterEntity.viewCount = viewCount;
	}
	final int? collectionCount = jsonConvert.convert<int>(json['collectionCount']);
	if (collectionCount != null) {
		userCenterEntity.collectionCount = collectionCount;
	}
	final int? jifen = jsonConvert.convert<int>(json['jifen']);
	if (jifen != null) {
		userCenterEntity.jifen = jifen;
	}
	final List<UserCenterCardInfoList>? cardInfoList = jsonConvert.convertListNotNull<UserCenterCardInfoList>(json['cardInfoList']);
	if (cardInfoList != null) {
		userCenterEntity.cardInfoList = cardInfoList;
	}
	final BankEntity? bank = jsonConvert.convert<BankEntity>(json['bank']);
	if (bank != null) {
		userCenterEntity.bank = bank;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		userCenterEntity.content = content;
	}
	return userCenterEntity;
}

Map<String, dynamic> $UserCenterEntityToJson(UserCenterEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['phone'] = entity.phone;
	data['followsCount'] = entity.followsCount;
	data['viewCount'] = entity.viewCount;
	data['collectionCount'] = entity.collectionCount;
	data['jifen'] = entity.jifen;
	data['cardInfoList'] =  entity.cardInfoList?.map((v) => v.toJson()).toList();
	data['bank'] = entity.bank?.toJson();
	data['content'] = entity.content;
	return data;
}

UserCenterCardInfoList $UserCenterCardInfoListFromJson(Map<String, dynamic> json) {
	final UserCenterCardInfoList userCenterCardInfoList = UserCenterCardInfoList();
	final String? cardUserNickname = jsonConvert.convert<String>(json['cardUserNickname']);
	if (cardUserNickname != null) {
		userCenterCardInfoList.cardUserNickname = cardUserNickname;
	}
	final String? professionalTitle = jsonConvert.convert<String>(json['professionalTitle']);
	if (professionalTitle != null) {
		userCenterCardInfoList.professionalTitle = professionalTitle;
	}
	final String? cardName = jsonConvert.convert<String>(json['cardName']);
	if (cardName != null) {
		userCenterCardInfoList.cardName = cardName;
	}
	final String? cardAvatar = jsonConvert.convert<String>(json['cardAvatar']);
	if (cardAvatar != null) {
		userCenterCardInfoList.cardAvatar = cardAvatar;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		userCenterCardInfoList.status = status;
	}
	final int? cardId = jsonConvert.convert<int>(json['cardId']);
	if (cardId != null) {
		userCenterCardInfoList.cardId = cardId;
	}
	final String? companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		userCenterCardInfoList.companyName = companyName;
	}
	return userCenterCardInfoList;
}

Map<String, dynamic> $UserCenterCardInfoListToJson(UserCenterCardInfoList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cardUserNickname'] = entity.cardUserNickname;
	data['professionalTitle'] = entity.professionalTitle;
	data['cardName'] = entity.cardName;
	data['cardAvatar'] = entity.cardAvatar;
	data['status'] = entity.status;
	data['cardId'] = entity.cardId;
	data['companyName'] = entity.companyName;
	return data;
}