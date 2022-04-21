import 'package:SDZ/entity/waimai/waimai_entity.dart';

waimaiEntityFromJson(WaimaiEntity data, Map<String, dynamic> json) {
	if (json['click_url'] != null) {
		data.clickUrl = json['click_url'].toString();
	}
	if (json['short_click_url'] != null) {
		data.shortClickUrl = json['short_click_url'].toString();
	}
	if (json['wx_miniprogram_path'] != null) {
		data.wxMiniprogramPath = json['wx_miniprogram_path'].toString();
	}
	if (json['wx_qrcode_url'] != null) {
		data.wxQrcodeUrl = json['wx_qrcode_url'].toString();
	}
	if (json['tpwd'] != null) {
		data.tpwd = json['tpwd'].toString();
	}
	if (json['long_tpwd'] != null) {
		data.longTpwd = json['long_tpwd'].toString();
	}
	if (json['app_id'] != null) {
		data.appId = json['app_id'].toString();
	}
	return data;
}

Map<String, dynamic> waimaiEntityToJson(WaimaiEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['click_url'] = entity.clickUrl;
	data['short_click_url'] = entity.shortClickUrl;
	data['wx_miniprogram_path'] = entity.wxMiniprogramPath;
	data['wx_qrcode_url'] = entity.wxQrcodeUrl;
	data['tpwd'] = entity.tpwd;
	data['long_tpwd'] = entity.longTpwd;
	data['app_id'] = entity.appId;
	return data;
}