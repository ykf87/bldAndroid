import 'package:SDZ/entity/waimai/activity_link_result_entity.dart';

activityLinkResultEntityFromJson(ActivityLinkResultEntity data, Map<String, dynamic> json) {
	if (json['terminalType'] != null) {
		data.terminalType = json['terminalType'].toString();
	}
	if (json['pageStartTime'] != null) {
		data.pageStartTime = json['pageStartTime'].toString();
	}
	if (json['pageName'] != null) {
		data.pageName = json['pageName'].toString();
	}
	if (json['click_url'] != null) {
		data.click_url = json['click_url'].toString();
	}
	if (json['short_click_url'] != null) {
		data.short_click_url = json['short_click_url'].toString();
	}
	if (json['wx_miniprogram_path'] != null) {
		data.wx_miniprogram_path = json['wx_miniprogram_path'].toString();
	}
	if (json['wx_qrcode_url'] != null) {
		data.wx_qrcode_url = json['wx_qrcode_url'].toString();
	}
	if (json['tpwd'] != null) {
		data.tpwd = json['tpwd'].toString();
	}
	if (json['long_tpwd'] != null) {
		data.long_tpwd = json['long_tpwd'].toString();
	}
	if (json['app_id'] != null) {
		data.app_id = json['app_id'].toString();
	}
	if (json['pageEndTime'] != null) {
		data.pageEndTime = json['pageEndTime'].toString();
	}
	return data;
}

Map<String, dynamic> activityLinkResultEntityToJson(ActivityLinkResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['terminalType'] = entity.terminalType;
	data['pageStartTime'] = entity.pageStartTime;
	data['pageName'] = entity.pageName;
	data['click_url'] = entity.click_url;
	data['short_click_url'] = entity.short_click_url;
	data['wx_miniprogram_path'] = entity.wx_miniprogram_path;
	data['wx_qrcode_url'] = entity.wx_qrcode_url;
	data['tpwd'] = entity.tpwd;
	data['long_tpwd'] = entity.long_tpwd;
	data['app_id'] = entity.app_id;
	data['pageEndTime'] = entity.pageEndTime;
	return data;
}