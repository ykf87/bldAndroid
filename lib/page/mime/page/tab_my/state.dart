import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/user_center_get_data.dart';

class Tab_myState {
  GlobalKey globalKey = new GlobalKey();
  bool isLogin = false;
  late String name;
  late String headUrl;
  late UserCenterEntity  userCenterEntity  = new UserCenterEntity();
   UserCenterCardInfoList?  cardInfo;
  StreamSubscription<LoginEvent>? loginEventBus;
  StreamSubscription<UserCenterEvent>? userCenterEventBus;

  Tab_myState() {
    ///Initialize variables
  }
}
