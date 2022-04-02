import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';



class Browse_recordsState {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  bool isShowEmpty = false;

  final List<MyBrowseRecordEntity> list = [
  ];

  Browse_recordsState() {
    ///Initialize variables
  }


}
