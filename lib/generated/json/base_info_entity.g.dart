import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/base_info_entity.dart';

BaseInfoEntity $BaseInfoEntityFromJson(Map<String, dynamic> json) {
	final BaseInfoEntity baseInfoEntity = BaseInfoEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		baseInfoEntity.avatar = avatar;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		baseInfoEntity.nickname = nickname;
	}
	final String? telephone = jsonConvert.convert<String>(json['telephone']);
	if (telephone != null) {
		baseInfoEntity.telephone = telephone;
	}
	final String? wechat = jsonConvert.convert<String>(json['wechat']);
	if (wechat != null) {
		baseInfoEntity.wechat = wechat;
	}
	final String? province = jsonConvert.convert<String>(json['province']);
	if (province != null) {
		baseInfoEntity.province = province;
	}
	final String? provinceCode = jsonConvert.convert<String>(json['provinceCode']);
	if (provinceCode != null) {
		baseInfoEntity.provinceCode = provinceCode;
	}
	final String? area = jsonConvert.convert<String>(json['area']);
	if (area != null) {
		baseInfoEntity.area = area;
	}
	final String? cityCode = jsonConvert.convert<String>(json['cityCode']);
	if (cityCode != null) {
		baseInfoEntity.cityCode = cityCode;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		baseInfoEntity.address = address;
	}
	final String? areaCode = jsonConvert.convert<String>(json['areaCode']);
	if (areaCode != null) {
		baseInfoEntity.areaCode = areaCode;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		baseInfoEntity.city = city;
	}
	return baseInfoEntity;
}

Map<String, dynamic> $BaseInfoEntityToJson(BaseInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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