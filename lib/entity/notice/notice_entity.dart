import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/notice_entity.g.dart';


/// 1-名片小助手;2-真香小管家;3-通告小助手 三个页面公用
@JsonSerializable()
class NoticeEntity {

	NoticeEntity();

	factory NoticeEntity.fromJson(Map<String, dynamic> json) => $NoticeEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeEntityToJson(this);

  int? total;
  List<NoticeItemEntity>? noticeList;
}

@JsonSerializable()
class NoticeItemEntity {

	NoticeItemEntity();

	factory NoticeItemEntity.fromJson(Map<String, dynamic> json) => $NoticeItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeItemEntityToJson(this);

  String? title; //消息标题
  int? noticeId; //消息ID
  int? relationId; //关联业务id
  int? readStatus; //0-未读; 1-已读
  String? noticeContent; //消息内容
  int? contentType; //内容类型，用于处理item跳转和显示逻辑
  int? createTime; //通知时间
  int?
      jumpType; //跳转页面: 参考内容类型: 参考https://jianke-hangzhou.yuque.com/xd0qgc/omppqq/ui8ok0
  int? actionType; //

  int jumpTarget() {
    if (actionType == 2 || actionType == 7 || actionType == 8) {
      ///2 PR名片审核未通过 7冻结提醒 8下架提醒
      return 1; //跳转APP
    } else if (actionType == 1 ||
        actionType == 11 ||
        actionType == 16 ||
        actionType == 19) {
      //1 Pr名片审核通过 11通告审核通过 16未确认合作 19通告完结
      return 0; //无跳转
    }
    return 2; //跳转小程序
  }
}
