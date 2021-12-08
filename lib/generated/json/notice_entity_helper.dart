import 'package:SDZ/entity/notice/notice_entity.dart';

noticeEntityFromJson(NoticeEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	if (json['noticeList'] != null) {
		data.noticeList = (json['noticeList'] as List).map((v) => NoticeItemEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> noticeEntityToJson(NoticeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	data['noticeList'] =  entity.noticeList?.map((v) => v.toJson())?.toList();
	return data;
}

noticeItemEntityFromJson(NoticeItemEntity data, Map<String, dynamic> json) {
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['noticeId'] != null) {
		data.noticeId = json['noticeId'] is String
				? int.tryParse(json['noticeId'])
				: json['noticeId'].toInt();
	}
	if (json['relationId'] != null) {
		data.relationId = json['relationId'] is String
				? int.tryParse(json['relationId'])
				: json['relationId'].toInt();
	}
	if (json['readStatus'] != null) {
		data.readStatus = json['readStatus'] is String
				? int.tryParse(json['readStatus'])
				: json['readStatus'].toInt();
	}
	if (json['noticeContent'] != null) {
		data.noticeContent = json['noticeContent'].toString();
	}
	if (json['contentType'] != null) {
		data.contentType = json['contentType'] is String
				? int.tryParse(json['contentType'])
				: json['contentType'].toInt();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'] is String
				? int.tryParse(json['createTime'])
				: json['createTime'].toInt();
	}
	if (json['jumpType'] != null) {
		data.jumpType = json['jumpType'] is String
				? int.tryParse(json['jumpType'])
				: json['jumpType'].toInt();
	}
	if (json['actionType'] != null) {
		data.actionType = json['actionType'] is String
				? int.tryParse(json['actionType'])
				: json['actionType'].toInt();
	}
	return data;
}

Map<String, dynamic> noticeItemEntityToJson(NoticeItemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
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