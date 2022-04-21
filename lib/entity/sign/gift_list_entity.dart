import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

import 'gift_entity.dart';

class GiftListEntity with JsonConvert<GiftListEntity> {
	@JSONField(name: "list")
	List<GiftEntity>? xList;
}

