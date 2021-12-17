// Package imports:
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/search/card_entity.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 首页商品列表
class IndexGoodsRepository extends LoadingMoreBase<GoodsEntity> {
  int page = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int pageSize = 20; // 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    page = 1;
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    var isSuccess = false;
    JtkApi.getGoodsList("", (result) {
      if (result != null) {
        addAll(result);
        page++;
        isSuccess = true;
      } else {
        isSuccess = false;
      }
      return isSuccess;
    }, pageSize: pageSize, page: page);
    return isSuccess;
  }
}
