import 'package:SDZ/entity/notice/notice_newest_msg_entity.dart';

noticeNewestMsgEntityFromJson(NoticeNewestMsgEntity data, Map<String, dynamic> json) {
	if (json['noticeType'] != null) {
		data.noticeType = json['noticeType'] is String
				? int.tryParse(json['noticeType'])
				: json['noticeType'].toInt();
	}
	if (json['noticeId'] != null) {
		data.noticeId = json['noticeId'] is String
				? int.tryParse(json['noticeId'])
				: json['noticeId'].toInt();
	}
	if (json['readStatus'] != null) {
		data.readStatus = json['readStatus'] is String
				? int.tryParse(json['readStatus'])
				: json['readStatus'].toInt();
	}
	return data;
}

Map<String, dynamic> noticeNewestMsgEntityToJson(NoticeNewestMsgEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['noticeType'] = entity.noticeType;
	data['noticeId'] = entity.noticeId;
	data['readStatus'] = entity.readStatus;
	return data;
}