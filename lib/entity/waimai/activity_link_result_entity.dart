import 'package:SDZ/generated/json/base/json_convert_content.dart';

class ActivityLinkResultEntity with JsonConvert<ActivityLinkResultEntity> {
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
