import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/base/get/controller/base_page_controller.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/utils/refresher_extension.dart';
import 'package:SDZ/widget/pull_smart_refresher.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

class GoodsListLogic extends GetxController {
  final state = GoodsListState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }


  void doRefresh() {
    state.pageNum = 1;
    state.list.clear();
    getData();
  }

  void doLoadMore() {
    state.pageNum++;
    getData();
  }

  void getData() {
    Map<String, dynamic> map = Map();
    map['pub_id'] = JtkApi.pub_id;
    map['source'] = state.source;
    // map['cat'] = pub_id;//分类
    // map['sub_share_rate'] = sub_share_rate;//分成比例 1代表100%，0.9代表90%，默认1
    map['page'] = state.pageNum;
    map['pageSize'] = 20;

    ApiClient.instance.get(ApiUrl.query_goods,data: map,isJTK: true, onSuccess: (data) {
      BaseEntity<List<GoodsEntity>> entity = BaseEntity.fromJson(data!);

      if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
        state.list.addAll(entity.data??[]);
        update();
      }
    });
  }
}
