import 'package:SDZ/entity/home/telephone_bill_entity.dart';

telephoneBillEntityFromJson(TelephoneBillEntity data, Map<String, dynamic> json) {
	if (json['h5_url'] != null) {
		data.h5_url = json['h5_url'].toString();
	}
	if (json['h5'] != null) {
		data.h5 = json['h5'].toString();
	}
	if (json['jtk_url'] != null) {
		data.jtk_url = json['jtk_url'].toString();
	}
	if (json['short_url'] != null) {
		data.short_url = json['short_url'].toString();
	}
	if (json['short_click_url'] != null) {
		data.short_click_url = json['short_click_url'].toString();
	}
	return data;
}

Map<String, dynamic> telephoneBillEntityToJson(TelephoneBillEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['h5_url'] = entity.h5_url;
	data['h5'] = entity.h5;
	data['jtk_url'] = entity.jtk_url;
	data['short_url'] = entity.short_url;
	data['short_click_url'] = entity.short_click_url;
	return data;
}