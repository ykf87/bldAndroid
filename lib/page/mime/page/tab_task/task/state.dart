import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class AdTaskState {
  AdTaskState() {
    ///Initialize variables
  }

  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  bool isShowEmpty = false;

  final List<AdTaskEntity> list = [
  ];
}
