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
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['phone'] != null) {
		data.phone = json['phone'].toString();
	}
	if (json['level'] != null) {
		data.level = json['level'].toString();
	}
	if (json['reg_time'] != null) {
		data.reg_time = json['reg_time'].toString();
	}
	if (json['last_login_time'] != null) {
		data.last_login_time = json['last_login_time'].toString();
	}
	if (json['jifen'] != null) {
		data.jifen = json['jifen'] is String
				? int.tryParse(json['jifen'])
				: json['jifen'].toInt();
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
	data['id'] = entity.id;
	data['phone'] = entity.phone;
	data['level'] = entity.level;
	data['reg_time'] = entity.reg_time;
	data['last_login_time'] = entity.last_login_time;
	data['jifen'] = entity.jifen;
	return data;
}