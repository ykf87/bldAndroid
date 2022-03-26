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
	double? sale;
	int? days;
	int? sendout;
	int? own;
	int? maxown;
	int? collection;
  
  GiftEntity();

  factory GiftEntity.fromJson(Map<String, dynamic> json) => $GiftListListFromJson(json);

  Map<String, dynamic> toJson() => $GiftListListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}