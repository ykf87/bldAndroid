import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';


class Browse_recordsState {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  bool isShowEmpty = false;



  Browse_recordsState() {
    ///Initialize variables
  }

  final List<MyBrowseRecordEntity> list = [
 ];
}
