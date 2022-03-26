import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/user_center_entity.g.dart';


import 'bank_entity.dart';

@JsonSerializable()
class UserCenterEntity {

	UserCenterEntity();

	factory UserCenterEntity.fromJson(Map<String, dynamic> json) => $UserCenterEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserCenterEntityToJson(this);

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

@JsonSerializable()
class UserCenterCardInfoList {

	UserCenterCardInfoList();

	factory UserCenterCardInfoList.fromJson(Map<String, dynamic> json) => $UserCenterCardInfoListFromJson(json);

	Map<String, dynamic> toJson() => $UserCenterCardInfoListToJson(this);

	String? cardUserNickname;
	String? professionalTitle;
	String? cardName;
	String? cardAvatar;
	int? status;
	int? cardId = 0;
	String? companyName;
}
