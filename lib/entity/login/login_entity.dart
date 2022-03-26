import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/login_entity.g.dart';



@JsonSerializable()
class LoginEntity {

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	String? accountId;
	String? token;
	String? telephone;
	String? nickname;
	String? avatar;


	String? id;
	String? phone;
	String? level;
	String? reg_time;
	String? last_login_time;
	int? jifen;

}
