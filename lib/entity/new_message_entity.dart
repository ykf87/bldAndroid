import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/new_message_entity.g.dart';


@JsonSerializable()
class NewMessageEntity {

	NewMessageEntity();

	factory NewMessageEntity.fromJson(Map<String, dynamic> json) => $NewMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $NewMessageEntityToJson(this);

	int? hasMessage;//0无 1有
	int? hasNotice;//0无 1有
}
