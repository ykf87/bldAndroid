import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/waimai/waimai_entity.dart';

WaimaiEntity $WaimaiEntityFromJson(Map<String, dynamic> json) {
	final WaimaiEntity waimaiEntity = WaimaiEntity();
	final String? clickUrl = jsonConvert.convert<String>(json['click_url']);
	if (clickUrl != null) {
		waimaiEntity.clickUrl = clickUrl;
	}
	final String? shortClickUrl = jsonConvert.convert<String>(json['short_click_url']);
	if (shortClickUrl != null) {
		waimaiEntity.shortClickUrl = shortClickUrl;
	}
	final String? wxMiniprogramPath = jsonConvert.convert<String>(json['wx_miniprogram_path']);
	if (wxMiniprogramPath != null) {
		waimaiEntity.wxMiniprogramPath = wxMiniprogramPath;
	}
	final String? wxQrcodeUrl = jsonConvert.convert<String>(json['wx_qrcode_url']);
	if (wxQrcodeUrl != null) {
		waimaiEntity.wxQrcodeUrl = wxQrcodeUrl;
	}
	final String? tpwd = jsonConvert.convert<String>(json['tpwd']);
	if (tpwd != null) {
		waimaiEntity.tpwd = tpwd;
	}
	final String? longTpwd = jsonConvert.convert<String>(json['long_tpwd']);
	if (longTpwd != null) {
		waimaiEntity.longTpwd = longTpwd;
	}
	final String? appId = jsonConvert.convert<String>(json['app_id']);
	if (appId != null) {
		waimaiEntity.appId = appId;
	}
	return waimaiEntity;
}

Map<String, dynamic> $WaimaiEntityToJson(WaimaiEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['click_url'] = entity.clickUrl;
	data['short_click_url'] = entity.shortClickUrl;
	data['wx_miniprogram_path'] = entity.wxMiniprogramPath;
	data['wx_qrcode_url'] = entity.wxQrcodeUrl;
	data['tpwd'] = entity.tpwd;
	data['long_tpwd'] = entity.longTpwd;
	data['app_id'] = entity.appId;
	return data;
}