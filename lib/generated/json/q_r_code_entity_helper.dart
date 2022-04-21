import 'package:SDZ/entity/talent/q_r_code_entity.dart';

qRCodeEntityFromJson(QRCodeEntity data, Map<String, dynamic> json) {
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	return data;
}

Map<String, dynamic> qRCodeEntityToJson(QRCodeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['url'] = entity.url;
	return data;
}