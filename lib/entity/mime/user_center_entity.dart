import 'package:SDZ/generated/json/base/json_convert_content.dart';

class UserCenterEntity with JsonConvert<UserCenterEntity> {
	String? nickname;
	String? avatar;
	int followsCount = 0;
	int viewCount = 0;
	int collectionCount = 0;
	List<UserCenterCardInfoList>? cardInfoList;
}

class UserCenterCardInfoList with JsonConvert<UserCenterCardInfoList> {
	String? cardUserNickname;
	String? professionalTitle;
	String? cardName;
	String? cardAvatar;
	int? status;
	int? cardId = 0;
	String? companyName;
}
