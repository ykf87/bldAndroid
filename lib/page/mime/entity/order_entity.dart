import 'package:SDZ/generated/json/base/json_convert_content.dart';

class OrderEntity {
	List<OrderList>? list;
}

class OrderList {
	int? id;
	String? price;
	int? num;
  String? pro_title;
	String? cover;
  String? kuaidi_num;
	String? status;
	String? created_at;

}