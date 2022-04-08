import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/page/mime/entity/order_entity.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyOrderState {
  MyOrderState() {
    ///Initialize variables
  }
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  bool isShowEmpty = false;

  final List<OrderList> list = [
  ];

}
