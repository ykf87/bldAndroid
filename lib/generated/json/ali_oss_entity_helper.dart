import 'package:SDZ/entity/mime/ali_oss_entity.dart';

aliOssEntityFromJson(AliOssEntity data, Map<String, dynamic> json) {
	if (json['securityToken'] != null) {
		data.securityToken = json['securityToken'].toString();
	}
	if (json['expiration'] != null) {
		data.expiration = json['expiration'].toString();
	}
	if (json['accessKeyId'] != null) {
		data.accessKeyId = json['accessKeyId'].toString();
	}
	if (json['accessKeySecret'] != null) {
		data.accessKeySecret = json['accessKeySecret'].toString();
	}
	if (json['domain'] != null) {
		data.domain = json['domain'].toString();
	}
	if (json['bucket'] != null) {
		data.bucket = json['bucket'].toString();
	}
	return data;
}

Map<String, dynamic> aliOssEntityToJson(AliOssEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['securityToken'] = entity.securityToken;
	data['expiration'] = entity.expiration;
	data['accessKeyId'] = entity.accessKeyId;
	data['accessKeySecret'] = entity.accessKeySecret;
	data['domain'] = entity.domain;
	data['bucket'] = entity.bucket;
	return data;
}