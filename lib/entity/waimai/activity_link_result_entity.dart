import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/activity_link_result_entity.g.dart';


@JsonSerializable()
class ActivityLinkResultEntity {

	ActivityLinkResultEntity();

	factory ActivityLinkResultEntity.fromJson(Map<String, dynamic> json) => $ActivityLinkResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $ActivityLinkResultEntityToJson(this);

  String? terminalType;
  String? pageStartTime;
  String? pageName;
  String? click_url;
  String? short_click_url;
  String? wx_miniprogram_path;
  String? wx_qrcode_url;
  String? tpwd;
  String? long_tpwd;
  String? app_id;
  String? pageEndTime;
}
