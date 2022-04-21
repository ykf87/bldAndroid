import 'package:SDZ/generated/json/base/json_convert_content.dart';

class TalentEntity with JsonConvert<TalentEntity> {
  String? nickname;
  String? avatar;
  String? introduce;
  List<String>? album;
  List<TalentCard>? cardList;
  // Map<int, int>? cardMap;
  List<TalentSkill>? skillTagList;
  int? isFollow; //是否关注: 1-关注; 0-未关注
  int? accountId; //用户ID
}

class TalentCard with JsonConvert<TalentCard> {
  int? cardType; //1-小红书，2-抖音，3-逛逛
  int? fansNum;
}

class TalentSkill with JsonConvert<TalentSkill> {
  int? skillId;
  String? skillLabel;
}
