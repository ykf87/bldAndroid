import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/notice/notice_newest_msg_entity.dart';

NoticeNewestMsgEntity $NoticeNewestMsgEntityFromJson(Map<String, dynamic> json) {
	final NoticeNewestMsgEntity noticeNewestMsgEntity = NoticeNewestMsgEntity();
	final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
	if (noticeType != null) {
		noticeNewestMsgEntity.noticeType = noticeType;
	}
	final int? noticeId = jsonConvert.convert<int>(json['noticeId']);
	if (noticeId != null) {
		noticeNewestMsgEntity.noticeId = noticeId;
	}
	final int? readStatus = jsonConvert.convert<int>(json['readStatus']);
	if (readStatus != null) {
		noticeNewestMsgEntity.readStatus = readStatus;
	}
	return noticeNewestMsgEntity;
}

Map<String, dynamic> $NoticeNewestMsgEntityToJson(NoticeNewestMsgEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['noticeType'] = entity.noticeType;
	data['noticeId'] = entity.noticeId;
	data['readStatus'] = entity.readStatus;
	return data;
}