import 'dart:async';

import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';

class GoodsListState {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  StreamSubscription<UserCenterEvent>? userCenterEventBus;
  bool isShowEmpty = false;//是否显示缺省

  GoodsListState() {
    ///Initialize variables
  }

  String source = 'taobao';//商品来源

  final List<GoodsEntity> list = [

  ];
}
