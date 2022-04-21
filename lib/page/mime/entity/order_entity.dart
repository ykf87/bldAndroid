import 'package:SDZ/generated/json/base/json_convert_content.dart';

class OrderEntity {
	List<OrderList>? list;
}

class OrderList {
	int? id;
	String? price;
	int? num;
  String? proTitle;
	String? cover;
  String? kuaidiNum;
	String? status;
	String? createdAt;

}