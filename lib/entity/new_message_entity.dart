import 'package:SDZ/generated/json/base/json_convert_content.dart';

class NewMessageEntity with JsonConvert<NewMessageEntity> {
	int? hasMessage;//0无 1有
	int? hasNotice;//0无 1有
}
