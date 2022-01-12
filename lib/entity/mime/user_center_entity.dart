import 'package:SDZ/generated/json/base/json_convert_content.dart';

import 'bank_entity.dart';

class UserCenterEntity with JsonConvert<UserCenterEntity> {
	String? nickname;
	String? avatar;
	String? phone;
	int followsCount = 0;
	int viewCount = 0;
	int collectionCount = 0;
	int jifen = 0;
	List<UserCenterCardInfoList>? cardInfoList;
	BankEntity? bank;
	String? content;
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
