import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class SignInfoEntity with JsonConvert<SignInfoEntity> {
	SignInfoUser? user;
	SignInfoSigned? signed;
	List<String> geted = [];
	bool? issigin;
}

class SignInfoUser with JsonConvert<SignInfoUser> {
	int? id;
	String? nickname;
	String? avatar;
	int? level;
	String? invitation;
	int? sex;
}

class SignInfoSigned with JsonConvert<SignInfoSigned> {
	SignInfoSignedProduct? product;
	int? id;
	@JSONField(name: "get_time")
	int? getTime;
	int? days;
	bool? mustadv;
	@JSONField(name: "need_day")
	int needDay = 0;
}

class SignInfoSignedProduct with JsonConvert<SignInfoSignedProduct> {
	int? id;
	String? name;
	String? cover;
	double? sale;
	int? sendout;
	int? own;
	int? maxown;
}
