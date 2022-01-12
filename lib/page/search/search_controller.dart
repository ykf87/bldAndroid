
import 'package:SDZ/base/get/controller/base_page_controller.dart';
import 'package:SDZ/entity/waimai/goods_detail_entity.dart';
import 'package:SDZ/widget/pull_smart_refresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

/// @class : SearchController
/// @date : 2021/9/3
/// @name : jhf
/// @description :搜索页面 控制器层
class SearchController extends BaseGetPageController {
  ///当前热词Widget，由于热词从服务器加载，需要动态添加
  RxList<GoodsDetailEntity> hotWord = <GoodsDetailEntity>[].obs;

  ///搜索框输入词
  RxString changeText = ''.obs;

  ///搜索历史记录，从SP中取出动态生成
  RxList<String> history = <String>[].obs;

  ///搜索结果
  RxList<GoodsDetailEntity> searchResult = <GoodsDetailEntity>[].obs;

  ///输入框文本控制器
  TextEditingController textController = TextEditingController(text: '');

  ///控制搜索结果
  var showResult = false.obs;

  @override
  void onInit() {
    super.onInit();
    isInit = false;
    notifySearchHistory();
    getSearchHotWord();
  }

  ///上拉下拉搜索数据加载
  @override
  void requestData(RefreshController controller,
      {Refresh refresh = Refresh.first}) {

  }

  ///获取搜索热词
  void getSearchHotWord() {

  }

  ///组建成搜索历史Widget
  void notifySearchHistory() {

  }

  ///点击搜索历史或者热搜榜中的item
  ///[items] 搜索的内容
  void hotOrHistorySearch(String items) {
    ///改变存储中的值
    changeText.value = items;
    ///改变输入框内容，并更新当前光标在尾部
    textController.text = items;
    textController.selection =
        TextSelection(baseOffset: items.length, extentOffset: items.length);
    searchWord();
  }

  ///点击搜索存储搜索记录
  void searchWord() {

  }

  ///清空搜索历史
  void clearSearchHistory() {

  }
}
