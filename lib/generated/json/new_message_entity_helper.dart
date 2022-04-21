import 'package:SDZ/entity/new_message_entity.dart';

newMessageEntityFromJson(NewMessageEntity data, Map<String, dynamic> json) {
	if (json['hasMessage'] != null) {
		data.hasMessage = json['hasMessage'] is String
				? int.tryParse(json['hasMessage'])
				: json['hasMessage'].toInt();
	}
	if (json['hasNotice'] != null) {
		data.hasNotice = json['hasNotice'] is String
				? int.tryParse(json['hasNotice'])
				: json['hasNotice'].toInt();
	}
	return data;
}

Map<String, dynamic> newMessageEntityToJson(NewMessageEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['hasMessage'] = entity.hasMessage;
	data['hasNotice'] = entity.hasNotice;
	return data;
}