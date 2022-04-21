import 'package:SDZ/generated/json/base/json_convert_content.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/7 16:02
/// @Description: 
class SkillEntity with JsonConvert<SkillEntity> {

  int? skillId;

  String? skillLabel;

  bool isSelect = false;
}