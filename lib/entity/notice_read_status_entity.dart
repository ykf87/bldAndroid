import 'package:SDZ/generated/json/base/json_convert_content.dart';

//用于显示3个小助手的红点
class NoticeReadStatusEntity with JsonConvert<NoticeReadStatusEntity> {
  int? noticeType;//消息类型: 1-名片小助手; 2-真香小管家; 3-通告小助
  int? noticeId;
  int? readStatus;//消息的读取状态: 1-已读; 0-未读
}
