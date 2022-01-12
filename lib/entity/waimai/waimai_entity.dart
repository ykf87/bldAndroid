import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class WaimaiEntity with JsonConvert<WaimaiEntity> {
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
