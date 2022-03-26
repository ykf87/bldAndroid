import 'package:SDZ/generated/json/waimai_entity.g.dart';

import 'package:SDZ/generated/json/base/json_field.dart';

@JsonSerializable()
class WaimaiEntity {

	WaimaiEntity();

	factory WaimaiEntity.fromJson(Map<String, dynamic> json) => $WaimaiEntityFromJson(json);

	Map<String, dynamic> toJson() => $WaimaiEntityToJson(this);

	@JSONField(name: "click_url")
	String? clickUrl;
	@JSONField(name: "short_click_url")
	String? shortClickUrl;
	@JSONField(name: "wx_miniprogram_path")
	String? wxMiniprogramPath;
	@JSONField(name: "wx_qrcode_url")
	String? wxQrcodeUrl;
	String? tpwd;
	@JSONField(name: "long_tpwd")
	String? longTpwd;
	@JSONField(name: "app_id")
	String? appId;
}
