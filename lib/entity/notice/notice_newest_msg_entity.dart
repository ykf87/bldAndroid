import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/notice_newest_msg_entity.g.dart';


//通知最新消息，目前主要用readStatus
@JsonSerializable()
class NoticeNewestMsgEntity {

	NoticeNewestMsgEntity();

	factory NoticeNewestMsgEntity.fromJson(Map<String, dynamic> json) => $NoticeNewestMsgEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeNewestMsgEntityToJson(this);

	int noticeType = 1;//消息类型: 1-名片小助手; 2-真香小管家; 3-通告小助手
	int? noticeId;
	int readStatus = 1;//0未读 1已读
}
