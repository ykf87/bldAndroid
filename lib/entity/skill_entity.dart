import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/skill_entity.g.dart';


/// @Author: ljx
/// @CreateDate: 2021/9/7 16:02
/// @Description: 
@JsonSerializable()
class SkillEntity {

	SkillEntity();

	factory SkillEntity.fromJson(Map<String, dynamic> json) => $SkillEntityFromJson(json);

	Map<String, dynamic> toJson() => $SkillEntityToJson(this);


  int? skillId;

  String? skillLabel;

  bool isSelect = false;
}