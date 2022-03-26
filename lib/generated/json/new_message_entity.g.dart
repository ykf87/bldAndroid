import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/new_message_entity.dart';

NewMessageEntity $NewMessageEntityFromJson(Map<String, dynamic> json) {
	final NewMessageEntity newMessageEntity = NewMessageEntity();
	final int? hasMessage = jsonConvert.convert<int>(json['hasMessage']);
	if (hasMessage != null) {
		newMessageEntity.hasMessage = hasMessage;
	}
	final int? hasNotice = jsonConvert.convert<int>(json['hasNotice']);
	if (hasNotice != null) {
		newMessageEntity.hasNotice = hasNotice;
	}
	return newMessageEntity;
}

Map<String, dynamic> $NewMessageEntityToJson(NewMessageEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['hasMessage'] = entity.hasMessage;
	data['hasNotice'] = entity.hasNotice;
	return data;
}