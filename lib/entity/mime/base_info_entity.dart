import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/base_info_entity.g.dart';


@JsonSerializable()
class BaseInfoEntity {

	BaseInfoEntity();

	factory BaseInfoEntity.fromJson(Map<String, dynamic> json) => $BaseInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoEntityToJson(this);

  late String avatar;
  late String nickname;
  late String telephone;
  String? wechat;
  String? province = '';
  late String provinceCode;
  String? area = '';
  late String cityCode;
   String? address;
  late String areaCode;
  String? city = '';
}
