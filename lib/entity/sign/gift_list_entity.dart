import 'dart:convert';
import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/gift_list_entity.g.dart';

@JsonSerializable()
class GiftListEntity {

	List<GiftEntity>? list;
  
  GiftListEntity();

  factory GiftListEntity.fromJson(Map<String, dynamic> json) => $GiftListEntityFromJson(json);

  Map<String, dynamic> toJson() => $GiftListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GiftEntity {

	int? id;
	String? cover;
	List<String>? images;
	String? name;
	String? title;
	double? sale;
	int? days;
	int? sendout;
	int? own;
	int? maxown;
	int? collection;
  
  GiftEntity();

  factory GiftEntity.fromJson(Map<String, dynamic> json) => $GiftEntityFromJson(json);

  Map<String, dynamic> toJson() => $GiftEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}