import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/talent/q_r_code_entity.dart';

QRCodeEntity $QRCodeEntityFromJson(Map<String, dynamic> json) {
	final QRCodeEntity qRCodeEntity = QRCodeEntity();
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		qRCodeEntity.url = url;
	}
	return qRCodeEntity;
}

Map<String, dynamic> $QRCodeEntityToJson(QRCodeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['url'] = entity.url;
	return data;
}