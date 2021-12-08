import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	String? accountId;
	String? token;
	String? telephone;
	String? nickname;
	String? avatar;

	/// 1 新用户 0 老用户
	@JSONField(name: 'isNewUser')
	int userType = 1;

	/// 注销账号登录: 1-是; 0-否
	int isCancelUser = 0;

	/// 是否新用户
	bool get isNewUser => userType == 1;

	/// 是否注销账号状态
	bool get isCancel => isCancelUser == 1;
}
