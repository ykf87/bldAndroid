import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/login/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
	final LoginEntity loginEntity = LoginEntity();
	final String? accountId = jsonConvert.convert<String>(json['accountId']);
	if (accountId != null) {
		loginEntity.accountId = accountId;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginEntity.token = token;
	}
	final String? telephone = jsonConvert.convert<String>(json['telephone']);
	if (telephone != null) {
		loginEntity.telephone = telephone;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		loginEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		loginEntity.avatar = avatar;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		loginEntity.id = id;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		loginEntity.phone = phone;
	}
	final String? level = jsonConvert.convert<String>(json['level']);
	if (level != null) {
		loginEntity.level = level;
	}
	final String? reg_time = jsonConvert.convert<String>(json['reg_time']);
	if (reg_time != null) {
		loginEntity.reg_time = reg_time;
	}
	final String? last_login_time = jsonConvert.convert<String>(json['last_login_time']);
	if (last_login_time != null) {
		loginEntity.last_login_time = last_login_time;
	}
	final int? jifen = jsonConvert.convert<int>(json['jifen']);
	if (jifen != null) {
		loginEntity.jifen = jifen;
	}
	return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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