import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/generated/json/base/json_field.dart';

class MyOrderEntity with JsonConvert<MyOrderEntity> {
	@JSONField(name: "list")
	List<MyOrderList>? xList;
}

class MyOrderList with JsonConvert<MyOrderList> {
	int? id;
	String? price;
	int? num;
	@JSONField(name: "pro_title")
	String? proTitle;
	String? cover;
	@JSONField(name: "kuaidi_num")
	dynamic? kuaidiNum;
	String? status;
	@JSONField(name: "created_at")
	String? createdAt;
}
