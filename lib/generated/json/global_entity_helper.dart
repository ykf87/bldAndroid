import 'package:SDZ/entity/global_entity.dart';

globalEntityFromJson(GlobalEntity data, Map<String, dynamic> json) {
	if (json['appname'] != null) {
		data.appname = json['appname'].toString();
	}
	if (json['version'] != null) {
		data.version = json['version'].toString();
	}
	if (json['versions'] != null) {
		data.versions = json['versions'].toString();
	}
	if (json['service'] != null) {
		data.service = json['service'].toString();
	}
	if (json['isadv'] != null) {
		data.isadv = json['isadv'].toString();
	}
	if (json['opensign'] != null) {
		data.opensign = json['opensign'] is String
				? int.tryParse(json['opensign'])
				: json['opensign'].toInt();
	}
	if (json['globaladv'] != null) {
		data.globaladv = json['globaladv'] is String
				? int.tryParse(json['globaladv'])
				: json['globaladv'].toInt();
	}
	if (json['jiliadv'] != null) {
		data.jiliadv = json['jiliadv'] is String
				? int.tryParse(json['jiliadv'])
				: json['jiliadv'].toInt();
	}
	return data;
}

Map<String, dynamic> globalEntityToJson(GlobalEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['appname'] = entity.appname;
	data['version'] = entity.version;
	data['versions'] = entity.versions;
	data['service'] = entity.service;
	data['isadv'] = entity.isadv;
	data['opensign'] = entity.opensign;
	data['globaladv'] = entity.globaladv;
	data['jiliadv'] = entity.jiliadv;
	return data;
}