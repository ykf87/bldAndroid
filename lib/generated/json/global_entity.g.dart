import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/global_entity.dart';

GlobalEntity $GlobalEntityFromJson(Map<String, dynamic> json) {
	final GlobalEntity globalEntity = GlobalEntity();
	final String? appname = jsonConvert.convert<String>(json['appname']);
	if (appname != null) {
		globalEntity.appname = appname;
	}
	final String? version = jsonConvert.convert<String>(json['version']);
	if (version != null) {
		globalEntity.version = version;
	}
	final String? versions = jsonConvert.convert<String>(json['versions']);
	if (versions != null) {
		globalEntity.versions = versions;
	}
	final String? service = jsonConvert.convert<String>(json['service']);
	if (service != null) {
		globalEntity.service = service;
	}
	final String? isadv = jsonConvert.convert<String>(json['isadv']);
	if (isadv != null) {
		globalEntity.isadv = isadv;
	}
	return globalEntity;
}

Map<String, dynamic> $GlobalEntityToJson(GlobalEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appname'] = entity.appname;
	data['version'] = entity.version;
	data['versions'] = entity.versions;
	data['service'] = entity.service;
	data['isadv'] = entity.isadv;
	return data;
}