import 'package:SDZ/entity/mime/bank_entity.dart';

bankEntityFromJson(BankEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['phone'] != null) {
		data.phone = json['phone'].toString();
	}
	if (json['number'] != null) {
		data.number = json['number'].toString();
	}
	if (json['bankname'] != null) {
		data.bankname = json['bankname'].toString();
	}
	return data;
}

Map<String, dynamic> bankEntityToJson(BankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['email'] = entity.email;
	data['phone'] = entity.phone;
	data['number'] = entity.number;
	data['bankname'] = entity.bankname;
	return data;
}