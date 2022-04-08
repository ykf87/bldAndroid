import 'dart:convert';
import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {

	List<OrderList>? list;
  
  OrderEntity();

  factory OrderEntity.fromJson(Map<String, dynamic> json) => $OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderList {

	int? id;
	String? price;
	int? num;
	@JSONField(name: "pro_title")
  String? proTitle;
	String? cover;
	@JSONField(name: "kuaidi_num")
  String? kuaidiNum;
	String? status;
	@JSONField(name: "created_at")
	String? createdAt;
  
  OrderList();

  factory OrderList.fromJson(Map<String, dynamic> json) => $OrderListFromJson(json);

  Map<String, dynamic> toJson() => $OrderListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}