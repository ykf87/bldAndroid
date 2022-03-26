import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/notice_read_status_entity.dart';

NoticeReadStatusEntity $NoticeReadStatusEntityFromJson(Map<String, dynamic> json) {
	final NoticeReadStatusEntity noticeReadStatusEntity = NoticeReadStatusEntity();
	final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
	if (noticeType != null) {
		noticeReadStatusEntity.noticeType = noticeType;
	}
	final int? noticeId = jsonConvert.convert<int>(json['noticeId']);
	if (noticeId != null) {
		noticeReadStatusEntity.noticeId = noticeId;
	}
	final int? readStatus = jsonConvert.convert<int>(json['readStatus']);
	if (readStatus != null) {
		noticeReadStatusEntity.readStatus = readStatus;
	}
	return noticeReadStatusEntity;
}

Map<String, dynamic> $NoticeReadStatusEntityToJson(NoticeReadStatusEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['noticeType'] = entity.noticeType;
	data['noticeId'] = entity.noticeId;
	data['readStatus'] = entity.readStatus;
	return data;
}