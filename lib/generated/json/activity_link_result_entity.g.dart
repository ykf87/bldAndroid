import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/waimai/activity_link_result_entity.dart';

ActivityLinkResultEntity $ActivityLinkResultEntityFromJson(Map<String, dynamic> json) {
	final ActivityLinkResultEntity activityLinkResultEntity = ActivityLinkResultEntity();
	final String? terminalType = jsonConvert.convert<String>(json['terminalType']);
	if (terminalType != null) {
		activityLinkResultEntity.terminalType = terminalType;
	}
	final String? pageStartTime = jsonConvert.convert<String>(json['pageStartTime']);
	if (pageStartTime != null) {
		activityLinkResultEntity.pageStartTime = pageStartTime;
	}
	final String? pageName = jsonConvert.convert<String>(json['pageName']);
	if (pageName != null) {
		activityLinkResultEntity.pageName = pageName;
	}
	final String? click_url = jsonConvert.convert<String>(json['click_url']);
	if (click_url != null) {
		activityLinkResultEntity.click_url = click_url;
	}
	final String? short_click_url = jsonConvert.convert<String>(json['short_click_url']);
	if (short_click_url != null) {
		activityLinkResultEntity.short_click_url = short_click_url;
	}
	final String? wx_miniprogram_path = jsonConvert.convert<String>(json['wx_miniprogram_path']);
	if (wx_miniprogram_path != null) {
		activityLinkResultEntity.wx_miniprogram_path = wx_miniprogram_path;
	}
	final String? wx_qrcode_url = jsonConvert.convert<String>(json['wx_qrcode_url']);
	if (wx_qrcode_url != null) {
		activityLinkResultEntity.wx_qrcode_url = wx_qrcode_url;
	}
	final String? tpwd = jsonConvert.convert<String>(json['tpwd']);
	if (tpwd != null) {
		activityLinkResultEntity.tpwd = tpwd;
	}
	final String? long_tpwd = jsonConvert.convert<String>(json['long_tpwd']);
	if (long_tpwd != null) {
		activityLinkResultEntity.long_tpwd = long_tpwd;
	}
	final String? app_id = jsonConvert.convert<String>(json['app_id']);
	if (app_id != null) {
		activityLinkResultEntity.app_id = app_id;
	}
	final String? pageEndTime = jsonConvert.convert<String>(json['pageEndTime']);
	if (pageEndTime != null) {
		activityLinkResultEntity.pageEndTime = pageEndTime;
	}
	return activityLinkResultEntity;
}

Map<String, dynamic> $ActivityLinkResultEntityToJson(ActivityLinkResultEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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