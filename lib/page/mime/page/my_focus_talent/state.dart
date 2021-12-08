import 'dart:async';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';

class My_focus_talentState {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();

  bool isShowEmpty = false;//是否显示缺省图
  StreamSubscription<UserCenterEvent>? userCenterEventBus;

  My_focus_talentState() {
    ///Initialize variables
  }

  final List<MyFocusTalentEntity> list = [];
}
