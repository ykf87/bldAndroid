import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/notice/notice_entity.dart';

NoticeEntity $NoticeEntityFromJson(Map<String, dynamic> json) {
	final NoticeEntity noticeEntity = NoticeEntity();
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		noticeEntity.total = total;
	}
	final List<NoticeItemEntity>? noticeList = jsonConvert.convertListNotNull<NoticeItemEntity>(json['noticeList']);
	if (noticeList != null) {
		noticeEntity.noticeList = noticeList;
	}
	return noticeEntity;
}

Map<String, dynamic> $NoticeEntityToJson(NoticeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total'] = entity.total;
	data['noticeList'] =  entity.noticeList?.map((v) => v.toJson()).toList();
	return data;
}

NoticeItemEntity $NoticeItemEntityFromJson(Map<String, dynamic> json) {
	final NoticeItemEntity noticeItemEntity = NoticeItemEntity();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		noticeItemEntity.title = title;
	}
	final int? noticeId = jsonConvert.convert<int>(json['noticeId']);
	if (noticeId != null) {
		noticeItemEntity.noticeId = noticeId;
	}
	final int? relationId = jsonConvert.convert<int>(json['relationId']);
	if (relationId != null) {
		noticeItemEntity.relationId = relationId;
	}
	final int? readStatus = jsonConvert.convert<int>(json['readStatus']);
	if (readStatus != null) {
		noticeItemEntity.readStatus = readStatus;
	}
	final String? noticeContent = jsonConvert.convert<String>(json['noticeContent']);
	if (noticeContent != null) {
		noticeItemEntity.noticeContent = noticeContent;
	}
	final int? contentType = jsonConvert.convert<int>(json['contentType']);
	if (contentType != null) {
		noticeItemEntity.contentType = contentType;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		noticeItemEntity.createTime = createTime;
	}
	final int? jumpType = jsonConvert.convert<int>(json['jumpType']);
	if (jumpType != null) {
		noticeItemEntity.jumpType = jumpType;
	}
	final int? actionType = jsonConvert.convert<int>(json['actionType']);
	if (actionType != null) {
		noticeItemEntity.actionType = actionType;
	}
	return noticeItemEntity;
}

Map<String, dynamic> $NoticeItemEntityToJson(NoticeItemEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['noticeId'] = entity.noticeId;
	data['relationId'] = entity.relationId;
	data['readStatus'] = entity.readStatus;
	data['noticeContent'] = entity.noticeContent;
	data['contentType'] = entity.contentType;
	data['createTime'] = entity.createTime;
	data['jumpType'] = entity.jumpType;
	data['actionType'] = entity.actionType;
	return data;
}