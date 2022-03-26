import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/ali_oss_entity.dart';

AliOssEntity $AliOssEntityFromJson(Map<String, dynamic> json) {
	final AliOssEntity aliOssEntity = AliOssEntity();
	final String? securityToken = jsonConvert.convert<String>(json['securityToken']);
	if (securityToken != null) {
		aliOssEntity.securityToken = securityToken;
	}
	final String? expiration = jsonConvert.convert<String>(json['expiration']);
	if (expiration != null) {
		aliOssEntity.expiration = expiration;
	}
	final String? accessKeyId = jsonConvert.convert<String>(json['accessKeyId']);
	if (accessKeyId != null) {
		aliOssEntity.accessKeyId = accessKeyId;
	}
	final String? accessKeySecret = jsonConvert.convert<String>(json['accessKeySecret']);
	if (accessKeySecret != null) {
		aliOssEntity.accessKeySecret = accessKeySecret;
	}
	final String? domain = jsonConvert.convert<String>(json['domain']);
	if (domain != null) {
		aliOssEntity.domain = domain;
	}
	final String? bucket = jsonConvert.convert<String>(json['bucket']);
	if (bucket != null) {
		aliOssEntity.bucket = bucket;
	}
	return aliOssEntity;
}

Map<String, dynamic> $AliOssEntityToJson(AliOssEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['securityToken'] = entity.securityToken;
	data['expiration'] = entity.expiration;
	data['accessKeyId'] = entity.accessKeyId;
	data['accessKeySecret'] = entity.accessKeySecret;
	data['domain'] = entity.domain;
	data['bucket'] = entity.bucket;
	return data;
}