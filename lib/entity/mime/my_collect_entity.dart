import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/my_collect_entity.g.dart';

import 'package:SDZ/utils/utils.dart';

@JsonSerializable()
class MyCollectEntity {

	MyCollectEntity();

	factory MyCollectEntity.fromJson(Map<String, dynamic> json) => $MyCollectEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyCollectEntityToJson(this);

  int? cardType;
  String? cardName;
  String? cardAvatar;
  int cardId = 0;
  int accountId = 0;
  int likesNum = 0;
  int fansNum = 0;
  int avgLikeNum = 0;
  List<MyCollectSkillTagList>? skillTagList;
  List<MyCollectSkillTagList>? skills;
  late List<CardWoksList> cardWorks = [];
  int gender = 0; //性别: 1-男; 2-女; 0-未知
  String? detailInfo;
  String province = '';
  String? city;
  String? headImageUrl;
  int followNum = 0;
  int isCollection = 0; //是否搜藏: 1-收藏;0-未收藏

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

  int getPosition() {
    if (cardType == 2) {
      return 3;
    } else if (cardType == 1) {
      return 1;
    } else if (cardType == 3) {
      return 2;
    }
    return 1;
  }

  String geSquareCardIcon() {
    if (cardType == 1) {
      return Utils.getSvgUrl('ic_xiaohongshu_square.svg');
    } else if (cardType == 2) {
      return Utils.getSvgUrl('ic_tiktok_square.svg');
    } else if (cardType == 3) {
      return Utils.getSvgUrl('ic_taobao_square.svg');
    }
    return '';
  }

  String geRoundCardIcon() {
    if (cardType == 1) {
      return Utils.getSvgUrl('ic_xiaohongshu.svg');
    } else if (cardType == 2) {
      return Utils.getSvgUrl('ic_tiktok.svg');
    } else if (cardType == 3) {
      return Utils.getSvgUrl('ic_taobao.svg');
    }
    return '';
  }
}

@JsonSerializable()
class MyCollectSkillTagList {

	MyCollectSkillTagList();

	factory MyCollectSkillTagList.fromJson(Map<String, dynamic> json) => $MyCollectSkillTagListFromJson(json);

	Map<String, dynamic> toJson() => $MyCollectSkillTagListToJson(this);

  late double skillId;
  late String skillLabel;
}

@JsonSerializable()
class CardWoksList {

	CardWoksList();

	factory CardWoksList.fromJson(Map<String, dynamic> json) => $CardWoksListFromJson(json);

	Map<String, dynamic> toJson() => $CardWoksListToJson(this);

  late String title;
  late String indexImgUrl;
  late int likeNum;
}
