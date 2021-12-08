import 'package:SDZ/entity/mime/base_info_entity.dart';

baseInfoEntityFromJson(BaseInfoEntity data, Map<String, dynamic> json) {
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['telephone'] != null) {
		data.telephone = json['telephone'].toString();
	}
	if (json['wechat'] != null) {
		data.wechat = json['wechat'].toString();
	}
	if (json['province'] != null) {
		data.province = json['province'].toString();
	}
	if (json['provinceCode'] != null) {
		data.provinceCode = json['provinceCode'].toString();
	}
	if (json['area'] != null) {
		data.area = json['area'].toString();
	}
	if (json['cityCode'] != null) {
		data.cityCode = json['cityCode'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['areaCode'] != null) {
		data.areaCode = json['areaCode'].toString();
	}
	if (json['city'] != null) {
		data.city = json['city'].toString();
	}
	return data;
}

Map<String, dynamic> baseInfoEntityToJson(BaseInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['avatar'] = entity.avatar;
	data['nickname'] = entity.nickname;
	data['telephone'] = entity.telephone;
	data['wechat'] = entity.wechat;
	data['province'] = entity.province;
	data['provinceCode'] = entity.provinceCode;
	data['area'] = entity.area;
	data['cityCode'] = entity.cityCode;
	data['address'] = entity.address;
	data['areaCode'] = entity.areaCode;
	data['city'] = entity.city;
	return data;
}