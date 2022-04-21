import 'package:SDZ/generated/json/base/json_convert_content.dart';

class GiftEntity with JsonConvert<GiftEntity> {
	int? id;
	String? name;
	String? cover;
	double? sale;
	int? sendout;
	int? own;
	int? maxown;
	List<String>? images;
	String? title;
	int? days;
	int? collection;
	bool isAd = false;
}
