import 'package:SDZ/page/mime/entity/my_order_entity.dart';

myOrderEntityFromJson(MyOrderEntity data, Map<String, dynamic> json) {
	if (json['list'] != null) {
		data.xList = (json['list'] as List).map((v) => MyOrderList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> myOrderEntityToJson(MyOrderEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['list'] =  entity.xList?.map((v) => v.toJson())?.toList();
	return data;
}

myOrderListFromJson(MyOrderList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['num'] != null) {
		data.num = json['num'] is String
				? int.tryParse(json['num'])
				: json['num'].toInt();
	}
	if (json['pro_title'] != null) {
		data.proTitle = json['pro_title'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['kuaidi_num'] != null) {
		data.kuaidiNum = json['kuaidi_num'];
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at'].toString();
	}
	return data;
}

Map<String, dynamic> myOrderListToJson(MyOrderList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['price'] = entity.price;
	data['num'] = entity.num;
	data['pro_title'] = entity.proTitle;
	data['cover'] = entity.cover;
	data['kuaidi_num'] = entity.kuaidiNum;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	return data;
}