import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/home/telephone_bill_entity.dart';

TelephoneBillEntity $TelephoneBillEntityFromJson(Map<String, dynamic> json) {
	final TelephoneBillEntity telephoneBillEntity = TelephoneBillEntity();
	final String? h5_url = jsonConvert.convert<String>(json['h5_url']);
	if (h5_url != null) {
		telephoneBillEntity.h5_url = h5_url;
	}
	final String? h5 = jsonConvert.convert<String>(json['h5']);
	if (h5 != null) {
		telephoneBillEntity.h5 = h5;
	}
	final String? jtk_url = jsonConvert.convert<String>(json['jtk_url']);
	if (jtk_url != null) {
		telephoneBillEntity.jtk_url = jtk_url;
	}
	final String? short_url = jsonConvert.convert<String>(json['short_url']);
	if (short_url != null) {
		telephoneBillEntity.short_url = short_url;
	}
	final String? short_click_url = jsonConvert.convert<String>(json['short_click_url']);
	if (short_click_url != null) {
		telephoneBillEntity.short_click_url = short_click_url;
	}
	return telephoneBillEntity;
}

Map<String, dynamic> $TelephoneBillEntityToJson(TelephoneBillEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['h5_url'] = entity.h5_url;
	data['h5'] = entity.h5;
	data['jtk_url'] = entity.jtk_url;
	data['short_url'] = entity.short_url;
	data['short_click_url'] = entity.short_click_url;
	return data;
}