import 'dart:async';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';


class My_collectState {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  StreamSubscription<UserCenterEvent>? userCenterEventBus;
  bool isShowEmpty = false;//是否显示缺省

  My_collectState() {
    ///Initialize variables
  }

  final List<MyCollectEntity> list = [

  ];
}
