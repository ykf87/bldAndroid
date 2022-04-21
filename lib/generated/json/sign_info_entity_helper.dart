import 'package:SDZ/entity/sign/sign_info_entity.dart';

signInfoEntityFromJson(SignInfoEntity data, Map<String, dynamic> json) {
	if (json['user'] != null) {
		data.user = SignInfoUser().fromJson(json['user']);
	}
	if (json['signed'] != null) {
		data.signed = SignInfoSigned().fromJson(json['signed']);
	}
	if (json['geted'] != null) {
		data.geted = (json['geted'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['issigin'] != null) {
		data.issigin = json['issigin'];
	}
	return data;
}

Map<String, dynamic> signInfoEntityToJson(SignInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user'] = entity.user?.toJson();
	data['signed'] = entity.signed?.toJson();
	data['geted'] = entity.geted;
	data['issigin'] = entity.issigin;
	return data;
}

signInfoUserFromJson(SignInfoUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['level'] != null) {
		data.level = json['level'] is String
				? int.tryParse(json['level'])
				: json['level'].toInt();
	}
	if (json['invitation'] != null) {
		data.invitation = json['invitation'].toString();
	}
	if (json['sex'] != null) {
		data.sex = json['sex'] is String
				? int.tryParse(json['sex'])
				: json['sex'].toInt();
	}
	return data;
}

Map<String, dynamic> signInfoUserToJson(SignInfoUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['level'] = entity.level;
	data['invitation'] = entity.invitation;
	data['sex'] = entity.sex;
	return data;
}

signInfoSignedFromJson(SignInfoSigned data, Map<String, dynamic> json) {
	if (json['product'] != null) {
		data.product = SignInfoSignedProduct().fromJson(json['product']);
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['get_time'] != null) {
		data.getTime = json['get_time'] is String
				? int.tryParse(json['get_time'])
				: json['get_time'].toInt();
	}
	if (json['days'] != null) {
		data.days = json['days'] is String
				? int.tryParse(json['days'])
				: json['days'].toInt();
	}
	if (json['mustadv'] != null) {
		data.mustadv = json['mustadv'];
	}
	if (json['need_day'] != null) {
		data.needDay = json['need_day'] is String
				? int.tryParse(json['need_day'])
				: json['need_day'].toInt();
	}
	return data;
}

Map<String, dynamic> signInfoSignedToJson(SignInfoSigned entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['product'] = entity.product?.toJson();
	data['id'] = entity.id;
	data['get_time'] = entity.getTime;
	data['days'] = entity.days;
	data['mustadv'] = entity.mustadv;
	data['need_day'] = entity.needDay;
	return data;
}

signInfoSignedProductFromJson(SignInfoSignedProduct data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['sale'] != null) {
		data.sale = json['sale'] is String
				? double.tryParse(json['sale'])
				: json['sale'].toDouble();
	}
	if (json['sendout'] != null) {
		data.sendout = json['sendout'] is String
				? int.tryParse(json['sendout'])
				: json['sendout'].toInt();
	}
	if (json['own'] != null) {
		data.own = json['own'] is String
				? int.tryParse(json['own'])
				: json['own'].toInt();
	}
	if (json['maxown'] != null) {
		data.maxown = json['maxown'] is String
				? int.tryParse(json['maxown'])
				: json['maxown'].toInt();
	}
	return data;
}

Map<String, dynamic> signInfoSignedProductToJson(SignInfoSignedProduct entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['cover'] = entity.cover;
	data['sale'] = entity.sale;
	data['sendout'] = entity.sendout;
	data['own'] = entity.own;
	data['maxown'] = entity.maxown;
	return data;
}