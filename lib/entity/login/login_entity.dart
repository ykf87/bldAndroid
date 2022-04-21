import 'package:SDZ/generated/json/base/json_convert_content.dart';


class LoginEntity with JsonConvert<LoginEntity> {
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
