import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/page/mime/entity/order_entity.dart';

OrderEntity $OrderEntityFromJson(Map<String, dynamic> json) {
	final OrderEntity orderEntity = OrderEntity();
	final List<OrderList>? list = jsonConvert.convertListNotNull<OrderList>(json['list']);
	if (list != null) {
		orderEntity.list = list;
	}
	return orderEntity;
}

Map<String, dynamic> $OrderEntityToJson(OrderEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.list?.map((v) => v.toJson()).toList();
	return data;
}

OrderList $OrderListFromJson(Map<String, dynamic> json) {
	final OrderList orderList = OrderList();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		orderList.id = id;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		orderList.price = price;
	}
	final int? num = jsonConvert.convert<int>(json['num']);
	if (num != null) {
		orderList.num = num;
	}
	final dynamic? proTitle = jsonConvert.convert<dynamic>(json['pro_title']);
	if (proTitle != null) {
		orderList.proTitle = proTitle;
	}
	final dynamic? cover = jsonConvert.convert<dynamic>(json['cover']);
	if (cover != null) {
		orderList.cover = cover;
	}
	final dynamic? kuaidiNum = jsonConvert.convert<dynamic>(json['kuaidi_num']);
	if (kuaidiNum != null) {
		orderList.kuaidiNum = kuaidiNum;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		orderList.status = status;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		orderList.createdAt = createdAt;
	}
	return orderList;
}

Map<String, dynamic> $OrderListToJson(OrderList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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