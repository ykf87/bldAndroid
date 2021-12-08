import 'package:SDZ/entity/login/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['accountId'] != null) {
		data.accountId = json['accountId'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	if (json['telephone'] != null) {
		data.telephone = json['telephone'].toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['isNewUser'] != null) {
		data.userType = json['isNewUser'] is String
				? int.tryParse(json['isNewUser'])
				: json['isNewUser'].toInt();
	}
	if (json['isCancelUser'] != null) {
		data.isCancelUser = json['isCancelUser'] is String
				? int.tryParse(json['isCancelUser'])
				: json['isCancelUser'].toInt();
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['accountId'] = entity.accountId;
	data['token'] = entity.token;
	data['telephone'] = entity.telephone;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['isNewUser'] = entity.userType;
	data['isCancelUser'] = entity.isCancelUser;
	return data;
}