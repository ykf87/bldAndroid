import 'dart:convert';
import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/sign_info_entity.g.dart';

@JsonSerializable()
class SignInfoEntity {

	SignInfoUser? user;
	SignInfoSigned? signed;
	bool issigin = false;
	List<String> geted = [];
  
  SignInfoEntity();

  factory SignInfoEntity.fromJson(Map<String, dynamic> json) => $SignInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $SignInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SignInfoUser {

	int? id;
	String? nickname;
	String? avatar;
	int? level;
	String? invitation;
	int? child;
	int? team;
	SignInfoUserParent? parent;
  
  SignInfoUser();

  factory SignInfoUser.fromJson(Map<String, dynamic> json) => $SignInfoUserFromJson(json);

  Map<String, dynamic> toJson() => $SignInfoUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SignInfoUserParent {

	int? id;
	String? nickname;
	String? avatar;
	int? level;
	int? team;
	String? invitation;
  
  SignInfoUserParent();

  factory SignInfoUserParent.fromJson(Map<String, dynamic> json) => $SignInfoUserParentFromJson(json);

  Map<String, dynamic> toJson() => $SignInfoUserParentToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SignInfoSigned {

	SignInfoSignedProduct? product;
	int? startat;
	int? days;//已签到天数
	@JSONField(name: "break")
	int? xBreak;
	int? mustdays;
	int? advs;
	bool mustadv = false;//是否需要不签
  int need_day = 0;//需要签到的天数
  int id = 0;////当前签到任务id

  SignInfoSigned();

  factory SignInfoSigned.fromJson(Map<String, dynamic> json) => $SignInfoSignedFromJson(json);

  Map<String, dynamic> toJson() => $SignInfoSignedToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SignInfoSignedProduct {

	int? id;
	String? name;
	String? cover;
	double? sale;
	int? sendout;
	int? own;
	int? maxown;
  
  SignInfoSignedProduct();

  factory SignInfoSignedProduct.fromJson(Map<String, dynamic> json) => $SignInfoSignedProductFromJson(json);

  Map<String, dynamic> toJson() => $SignInfoSignedProductToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}