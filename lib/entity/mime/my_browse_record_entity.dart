import 'package:SDZ/generated/json/my_browse_record_entity.g.dart';

import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

@JsonSerializable()
class MyBrowseRecordEntity {

	MyBrowseRecordEntity();

	factory MyBrowseRecordEntity.fromJson(Map<String, dynamic> json) => $MyBrowseRecordEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyBrowseRecordEntityToJson(this);

  String? nickname;
  String? avatar;
  int? accountId;
  // List<MyBrowseRecordSkillTagList>? skillTagList;
  List<MyBrowseRecordSkillTagList>? skillTagList;
  List<MyCollectEntity>? cardList;//达人名片
  String? introduce;
  List<String>? album;
  String province = '';
  String? city;
	/// 是否关注: 1-关注; 0-未关注
	@JSONField(name: 'isFollow')
	int? follow;
	/// 未关注状态是否播放svg动画
	bool isPlaySvg = false;

	bool get isFollow => follow == 1;
}

@JsonSerializable()
class MyBrowseRecordSkillTagList {

	MyBrowseRecordSkillTagList();

	factory MyBrowseRecordSkillTagList.fromJson(Map<String, dynamic> json) => $MyBrowseRecordSkillTagListFromJson(json);

	Map<String, dynamic> toJson() => $MyBrowseRecordSkillTagListToJson(this);

	int? skillId;
	String? skillLabel;
}

