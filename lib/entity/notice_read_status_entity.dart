import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/notice_read_status_entity.g.dart';


//用于显示3个小助手的红点
@JsonSerializable()
class NoticeReadStatusEntity {

	NoticeReadStatusEntity();

	factory NoticeReadStatusEntity.fromJson(Map<String, dynamic> json) => $NoticeReadStatusEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeReadStatusEntityToJson(this);

  int? noticeType;//消息类型: 1-名片小助手; 2-真香小管家; 3-通告小助
  int? noticeId;
  int? readStatus;//消息的读取状态: 1-已读; 0-未读
}
