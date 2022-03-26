import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/my_focus_talent_entity.g.dart';


@JsonSerializable()
class MyFocusTalentEntity {

	MyFocusTalentEntity();

	factory MyFocusTalentEntity.fromJson(Map<String, dynamic> json) => $MyFocusTalentEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyFocusTalentEntityToJson(this);

	String? nickname;
	String? avatar;
	int? accountId;
	List<MyFocusTalentSkillTagList>? skillTagList;
	List<MyFocusTalentCardList>? cardList;
}

@JsonSerializable()
class MyFocusTalentSkillTagList {

	MyFocusTalentSkillTagList();

	factory MyFocusTalentSkillTagList.fromJson(Map<String, dynamic> json) => $MyFocusTalentSkillTagListFromJson(json);

	Map<String, dynamic> toJson() => $MyFocusTalentSkillTagListToJson(this);

	int? skillId;
	String? skillLabel;
}

@JsonSerializable()
class MyFocusTalentCardList {

	MyFocusTalentCardList();

	factory MyFocusTalentCardList.fromJson(Map<String, dynamic> json) => $MyFocusTalentCardListFromJson(json);

	Map<String, dynamic> toJson() => $MyFocusTalentCardListToJson(this);

	int? cardType;
	String? fansNum;

	String getCardTypeName() {
		if (cardType == 2) {
			return '抖音';
		} else if (cardType == 1) {
			return '小红书';
		} else if (cardType == 3) {
			return '逛逛';
		}
		return '';
	}
	String getCardTypeIcon() {
		if (cardType == 2) {
			return 'assets/svg/ic_tiktok.svg';
		} else if (cardType == 1) {
			return 'assets/svg/ic_xiaohongshu.svg';
		} else if (cardType == 3) {
			return 'assets/svg/ic_taobao.svg';
		}
		return '';
	}

}
