import 'package:SDZ/entity/mime/bank_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';

userCenterEntityFromJson(UserCenterEntity data, Map<String, dynamic> json) {
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['phone'] != null) {
		data.phone = json['phone'].toString();
	}
	if (json['followsCount'] != null) {
		data.followsCount = json['followsCount'] is String
				? int.tryParse(json['followsCount'])
				: json['followsCount'].toInt();
	}
	if (json['viewCount'] != null) {
		data.viewCount = json['viewCount'] is String
				? int.tryParse(json['viewCount'])
				: json['viewCount'].toInt();
	}
	if (json['collectionCount'] != null) {
		data.collectionCount = json['collectionCount'] is String
				? int.tryParse(json['collectionCount'])
				: json['collectionCount'].toInt();
	}
	if (json['jifen'] != null) {
		data.jifen = json['jifen'] is String
				? int.tryParse(json['jifen'])
				: json['jifen'].toInt();
	}
	if (json['cardInfoList'] != null) {
		data.cardInfoList = (json['cardInfoList'] as List).map((v) => UserCenterCardInfoList().fromJson(v)).toList();
	}
	if (json['bank'] != null) {
		data.bank = BankEntity().fromJson(json['bank']);
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	return data;
}

Map<String, dynamic> userCenterEntityToJson(UserCenterEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['phone'] = entity.phone;
	data['followsCount'] = entity.followsCount;
	data['viewCount'] = entity.viewCount;
	data['collectionCount'] = entity.collectionCount;
	data['jifen'] = entity.jifen;
	data['cardInfoList'] =  entity.cardInfoList?.map((v) => v.toJson())?.toList();
	data['bank'] = entity.bank?.toJson();
	data['content'] = entity.content;
	return data;
}

userCenterCardInfoListFromJson(UserCenterCardInfoList data, Map<String, dynamic> json) {
	if (json['cardUserNickname'] != null) {
		data.cardUserNickname = json['cardUserNickname'].toString();
	}
	if (json['professionalTitle'] != null) {
		data.professionalTitle = json['professionalTitle'].toString();
	}
	if (json['cardName'] != null) {
		data.cardName = json['cardName'].toString();
	}
	if (json['cardAvatar'] != null) {
		data.cardAvatar = json['cardAvatar'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	if (json['cardId'] != null) {
		data.cardId = json['cardId'] is String
				? int.tryParse(json['cardId'])
				: json['cardId'].toInt();
	}
	if (json['companyName'] != null) {
		data.companyName = json['companyName'].toString();
	}
	return data;
}

Map<String, dynamic> userCenterCardInfoListToJson(UserCenterCardInfoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cardUserNickname'] = entity.cardUserNickname;
	data['professionalTitle'] = entity.professionalTitle;
	data['cardName'] = entity.cardName;
	data['cardAvatar'] = entity.cardAvatar;
	data['status'] = entity.status;
	data['cardId'] = entity.cardId;
	data['companyName'] = entity.companyName;
	return data;
}