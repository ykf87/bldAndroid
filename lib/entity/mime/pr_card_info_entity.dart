import 'package:SDZ/generated/json/base/json_convert_content.dart';
///PR名片
class PrCardInfoEntity with JsonConvert<PrCardInfoEntity> {
	late int identityType;
	late String companyName;
	late String professionalTitle;
	late String cardAvatar;
	late List<PrCardInfoSkills> skills;
	 int? status;//认证状态: 1未认证、2认证中、3已认证
	 String? remark;
}

class PrCardInfoSkills with JsonConvert<PrCardInfoSkills> {
	 int skillId = 0;
	late String skillLabel;
}
