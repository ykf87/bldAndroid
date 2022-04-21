import 'package:SDZ/generated/json/base/json_convert_content.dart';

class MyFocusTalentEntity with JsonConvert<MyFocusTalentEntity> {
	String? nickname;
	String? avatar;
	int? accountId;
	List<MyFocusTalentSkillTagList>? skillTagList;
	List<MyFocusTalentCardList>? cardList;
}

class MyFocusTalentSkillTagList with JsonConvert<MyFocusTalentSkillTagList> {
	int? skillId;
	String? skillLabel;
}

class MyFocusTalentCardList with JsonConvert<MyFocusTalentCardList> {
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
