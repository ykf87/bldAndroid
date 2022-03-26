import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/bank_entity.dart';

BankEntity $BankEntityFromJson(Map<String, dynamic> json) {
	final BankEntity bankEntity = BankEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		bankEntity.id = id;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		bankEntity.email = email;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		bankEntity.phone = phone;
	}
	final String? number = jsonConvert.convert<String>(json['number']);
	if (number != null) {
		bankEntity.number = number;
	}
	final String? bankname = jsonConvert.convert<String>(json['bankname']);
	if (bankname != null) {
		bankEntity.bankname = bankname;
	}
	return bankEntity;
}

Map<String, dynamic> $BankEntityToJson(BankEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['email'] = entity.email;
	data['phone'] = entity.phone;
	data['number'] = entity.number;
	data['bankname'] = entity.bankname;
	return data;
}