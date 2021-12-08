import 'package:SDZ/generated/json/base/json_convert_content.dart';

class PrListSkillEntity with JsonConvert<PrListSkillEntity> {
	late int skillId;
	late String skillLabel;
	late bool isSelect = false;
}
